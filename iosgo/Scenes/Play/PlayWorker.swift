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
        case success(stones: [Stone])
        case error(message: String)
    }

    private var gameStore: GameStore
    private var game: Game!

    init(gameStore: GameStore) {
        self.gameStore = gameStore
    }

    func loadGame(id: Int, completion: @escaping (LoadResult) -> Void) {

        gameStore.game(id: id) { storeResponse in

            var loadResult: LoadResult!

            switch storeResponse.result {
            case .success(let game):
                self.game = game
                let stones = self.getStones(from: game)
                loadResult = .success(stones: stones)
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

    func getStones(from game: Game) -> [Stone] {

        var stones = [Stone]()
        var currentType: StoneType = (game.gameData.initialPlayer == .black) ? .black : .white

        for move in game.moves {
            let stone = Stone(type: currentType, point: gridPoint(from: move, game: game))
            stones.append(stone)

            currentType = (currentType == .black) ? .white : .black
        }

        return stones
    }

    private func gridPoint(from move: Move, game: Game) -> GridPoint {
        let row = game.height - move.y
        let col = move.x + 1
        return GridPoint(row: row, col: col)
    }
}
