//
//  GameRenderer.swift
//  iosgo
//
//  Created by Cheese Onhead on 7/2/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class GameRenderer {

    var gameEngine: GameEngine

    required init(gameEngine: GameEngine) {
        self.gameEngine = gameEngine
    }

    func getStones() -> [GridStone] {

        var gridStones = [GridStone]()
        let boardStones = gameEngine.board.allStones()

        for (boardPoint, boardStone) in boardStones {
            let gridStone = GridStone(type: boardStone.type, point: gridPoint(from: boardPoint, game: self.gameEngine.game))
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
