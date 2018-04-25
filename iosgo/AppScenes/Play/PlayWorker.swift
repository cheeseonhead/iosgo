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
    private var clockController: ClockController?
    weak var delegate: PlayWorkerDelegate?

    private var clocks: [PlayerType: Clock.TimeType]?

    init(gameStore: GameAPI, imageApi: AvatarApi) {
        self.gameStore = gameStore
        self.imageApi = imageApi
    }

    func loadGame(id: Int) -> Promise<Play.LoadGame.Response> {

        return gameStore.game(id: id).then { game -> Promise<Game> in
            self.gameEngine = GameEngine(game: game)

            self.setupClockController(game)

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
        let blackIconPromise = imageApi.getImage(fullUrl: players.black.icon, size: DefaultImageSize)
        let whiteIconPromise = imageApi.getImage(fullUrl: players.white.icon, size: DefaultImageSize)

        return when(fulfilled: [blackIconPromise, whiteIconPromise]).map {
            array in (array[0], array[1])
        }
    }

    func response(from game: Game, images: (black: UIImage, white: UIImage)) -> Play.LoadGame.Response {
        let response = Play.LoadGame.Response(state: gameEngine.getState(), game: game, icons: images)

        return response
    }
}

// MARK: - GameSocket Delegate
extension PlayWorker: GameSocketDelegate {
    func handleMove(_ move: BoardPoint) {
        try? gameEngine.place(at: move)
        delegate?.gameUpdated(state: gameEngine.getState())

        clockController?.changePhase(.playing)
    }

    func handleClock(_ clock: Clock) {

        clockController?.setClock(clock, phase: ClockController.Phase(movesCount: gameEngine.currentMove.moveNumber))
    }

    func updateGameData(_ gameData: GameData) {
        gameEngine.update(with: gameData)
        delegate?.gameUpdated(state: gameEngine.getState())
    }
}

// MARK: - ClockController Delegate
extension PlayWorker: ClockControllerDelegate {

    func setupClockController(_ game: Game) {
        guard game.ended == nil else {
            return
        }

        clockController = ClockController(clock: game.gamedata.clock, phase: ClockController.Phase(movesCount: gameEngine.currentMove.moveNumber))
        clockController?.delegate = self
        clockController?.countDownLoop()
    }

    func clockUpdated(_ clock: Clock) {
        let response = Play.UpdateClock.Response(clock: clock)

        delegate?.gameClockUpdated(response)
    }
}
