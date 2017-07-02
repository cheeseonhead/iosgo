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
        case success(stones: [GridStone])
        case error(message: String)
    }

    private var gameStore: GameStore
    private var game: Game!
    private var gameEngine: GameEngine!
    private var gameRenderer: GameRenderer!

    init(gameStore: GameStore) {
        self.gameStore = gameStore
    }

    func loadGame(id: Int, completion: @escaping (LoadResult) -> Void) {

        gameStore.game(id: id) { storeResponse in

            var loadResult: LoadResult!

            switch storeResponse.result {
            case .success(let game):
                self.game = game

                self.gameEngine = GameEngine(game: game)
                self.gameRenderer = GameRenderer(gameEngine: self.gameEngine)
                loadResult = .success(stones: self.gameRenderer.getStones())
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
