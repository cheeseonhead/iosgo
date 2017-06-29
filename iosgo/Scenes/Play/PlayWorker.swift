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
                loadResult = .success(stones: self.getStones())
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

extension PlayWorker {

    func getStones() -> [GridStone] {

        var gridStones = [GridStone]()
        let boardStones = gameEngine.board.allStones()

        for (boardPoint, boardStone) in boardStones {
            let gridStone = GridStone(type: boardStone.type, point: gridPoint(from: boardPoint, game: game))
            gridStones.append(gridStone)
        }

        return gridStones
    }

    private func gridPoint(from move: BoardPoint, game: Game) -> GridPoint {
        let row = game.height - move.row
        let col = move.column + 1
        return GridPoint(row: row, col: col)
    }
}
