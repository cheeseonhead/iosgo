//
//  PlayWorker.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/18/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation

protocol PlayWorkerDelegate: class {
    func gameUpdated(state: GoState)
}

class PlayWorker {

    enum LoadResult {
        case success(stones: GoState)
        case error(message: String)
    }

    private var gameStore: GameStore
    private var gameEngine: GameEngine!
    private var gameSocket: GameSocket!
    weak var delegate: PlayWorkerDelegate?

    init(gameStore: GameStore) {
        self.gameStore = gameStore
    }

    func loadGame(id: Int, completion: @escaping (LoadResult) -> Void) {

        gameStore.game(id: id) { storeResponse in

            var loadResult: LoadResult!

            switch storeResponse.result {
            case .success(let game):
                self.gameEngine = GameEngine(game: game)
                loadResult = .success(stones: self.gameEngine.getState())
                self.connectSocket()
            case .error(let type):
                switch type {
                case .genericError(let message):
                    loadResult = .error(message: message)
                default: break
                }
            }

            completion(loadResult)
        }
    }
}

// MARK: - Load Game Helpers
private extension PlayWorker {

    func connectSocket() {

        guard let playerId = OGSSessionController.sharedInstance.current.user?.id else {
            return
        }

        gameSocket = GameSocket(socketManager: SocketManager.sharedInstance, gameId: gameEngine.game.id, playerId: playerId)
        gameSocket.delegate = self
        gameSocket.connect()
    }
}

// MARK: - GameSocket Delegate
extension PlayWorker: GameSocketDelegate {

    func handleMove(_ move: BoardPoint) {
        try? gameEngine.place(at: move)
        delegate?.gameUpdated(state: gameEngine.getState())
    }

    func updateGameData(_ gameData: GameData) {
        gameEngine.update(with: gameData)
        delegate?.gameUpdated(state: gameEngine.getState())
    }
}
