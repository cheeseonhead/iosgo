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

    private var clocks: [PlayerType: Clock.Time]?

    init(gameStore: GameAPI, imageApi: AvatarApi) {
        self.gameStore = gameStore
        self.imageApi = imageApi
    }

    func loadGame(id: Int) -> Promise<Play.LoadGame.Response> {
        return gameStore.game(id: id).then { game -> Promise<Game> in
            self.gameEngine = GameEngine(game: game)

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

        clockController?.setTimeType(gameEngine.game.timeControl)
    }

    func handleClock(_ clock: Clock) {
        clockController?.setGameClock(clock)
    }

    func updateGameData(_ gameData: GameData) {
        gameEngine.update(with: gameData)

        setupClockController(gameData)

        delegate?.gameUpdated(state: gameEngine.getState())
    }
}

// MARK: - ClockController Delegate

extension PlayWorker: ClockControllerDelegate {
    func setupClockController(_ gameData: GameData) {
        guard gameEngine.game.ended == nil else {
            return
        }

        if gameEngine.currentMove.moveNumber > 0 {
            clockController = ClockController(clock: gameData.clock, type: gameEngine.game.timeControl)
        } else {
            clockController = ClockController(clock: gameData.clock, type: .pregame)
        }

        clockController?.delegate = self
    }

    func clockUpdated(_ clock: Clock, type: TimeControlType) {
        let response = Play.UpdateClock.Response(clock: clock, clockType: type)

        delegate?.gameClockUpdated(response)
    }
}
