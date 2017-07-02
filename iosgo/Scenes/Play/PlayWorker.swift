//
//  PlayWorker.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/18/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class PlayWorker {

    enum LoadResult {
        case success(stones: GoState)
        case error(message: String)
    }

    private var gameStore: GameStore
    private var gameEngine: GameEngine!
    private var gameSocket: GameSocket!

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
        gameSocket.connect()
    }
}
