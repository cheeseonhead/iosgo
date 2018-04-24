//
//  PlayWorker.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/18/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import PromiseKit

protocol PlayWorkerDelegate: class {
    func gameUpdated(state: GoState)
    func gameClockUpdated(_ response: Play.UpdateClock.Response)
}

class PlayWorker {
    enum LoadResult {
        case success(stones: GoState)
        case error(message: String)
    }

    private let DefaultImageSize = 256

    private var gameStore: GameAPI
    private var imageApi: AvatarApi
    private var gameEngine: GameEngine!
    private var gameSocket: GameSocket!
    weak var delegate: PlayWorkerDelegate?

    private var clocks: [PlayerType: Clock.TimeType]?

    init(gameStore: GameAPI, imageApi: AvatarApi) {
        self.gameStore = gameStore
        self.imageApi = imageApi
    }

    func loadGame(id: Int) -> Promise<Play.LoadGame.Response> {

        return gameStore.game(id: id).then { game -> Promise<Game> in
            self.gameEngine = GameEngine(game: game)

            self.setClocks(game.gamedata.clock)
            self.countDownLoop()

            return self.connectSocket().map { _ in game }
        }.then { game -> Promise<Play.LoadGame.Response> in
            self.getIcons(players: game.players).map { images in
                self.response(from: game, images: images)
            }
        }
    }

    func submitMove(_ move: GridPoint) {
        let prettyPoint = gameEngine.boardPoint(forGridPoint: move).toLetters()
        gameSocket.submitMove(prettyPoint)
    }
}

// MARK: - Load Game Helpers
private extension PlayWorker {
    func connectSocket() -> Promise<()> {
        let promise = firstly { () -> Promise<()> in
            guard let playerId = OGSSessionController.sharedInstance.current.user?.id else {
                throw SessionError.noCurrentConfiguration
            }

            gameSocket = GameSocket(socketManager: SocketManager.sharedInstance, gameId: gameEngine.game.id, playerId: playerId)
            gameSocket.delegate = self
            return gameSocket.connect()
        }
        return promise
    }

    func getIcons(players: Game.Players) -> Promise<(black: UIImage, white: UIImage)> {
        let blackURL = players.black.icon
        let whiteURL = players.white.icon

        return when(fulfilled: [imageApi.getImage(fullUrl: blackURL, size: DefaultImageSize), imageApi.getImage(fullUrl: whiteURL, size: DefaultImageSize)]).map {
            array in
            (array[0], array[1])
        }
    }

    func response(from game: Game, images: (black: UIImage, white: UIImage)) -> Play.LoadGame.Response {
        let blackUser = Play.LoadGame.Response.User(username: game.players.black.username, icon: images.black)
        let whiteUser = Play.LoadGame.Response.User(username: game.players.white.username, icon: images.white)
        let response = Play.LoadGame.Response(state: gameEngine.getState(),
                                              clock: game.gamedata.clock,
                                              black: blackUser,
                                              white: whiteUser)

        return response
    }
}

// MARK: - GameSocket Delegate
extension PlayWorker: GameSocketDelegate {
    func handleMove(_ move: BoardPoint) {
        try? gameEngine.place(at: move)
        delegate?.gameUpdated(state: gameEngine.getState())
    }

    func handleClock(_ clock: Clock) {
        let response = Play.UpdateClock.Response(blackClock: clock.blackTime, whiteClock: clock.whiteTime)

        delegate?.gameClockUpdated(response)
    }

    func updateGameData(_ gameData: GameData) {
        gameEngine.update(with: gameData)
        delegate?.gameUpdated(state: gameEngine.getState())
    }
}

// MARK: - Clock Helpers
private extension PlayWorker {
    func setClocks(_ clock: Clock) {
        if let bTime = clock.blackTime {
            clocks = [:]
            clocks?[.black] = bTime
        }

        if let wTime = clock.whiteTime {
            clocks?[.white] = wTime
        }
    }

    func countDownClocks(timePassed: TimeInterval) {
        clocks?[.black]?.countDown(timePassed: timePassed)
        clocks?[.white]?.countDown(timePassed: timePassed)
    }

    func updateClock() {
        let response = Play.UpdateClock.Response(blackClock: clocks?[.black], whiteClock: clocks?[.white])

        delegate?.gameClockUpdated(response)
    }

    func countDownLoop() {
        var lastTime = Date()
        delay(1) { [weak self] in
            let now = Date()
            self?.countDownClocks(timePassed: now.timeIntervalSince(lastTime))
            lastTime = now

            self?.updateClock()

            self?.countDownLoop()
        }
    }
}
