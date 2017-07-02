//
//  GameRenderer.swift
//  iosgo
//
//  Created by Cheese Onhead on 7/2/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class GameRenderer {

    func getState(from goState: GoState) -> GridState {

        let gridStones = getStones(from: goState)
        let blackPrisoners = goState.blackPrisoners
        let whitePrisoners = goState.whitePrisoners

        let state = GridState(blackPrisoners: blackPrisoners, whitePrisoners: whitePrisoners, stones: gridStones)

        return state
    }
}

// MARK: - Helpers
private extension GameRenderer {

    func getStones(from goState: GoState) -> [GridStone] {

        var gridStones = [GridStone]()
        let boardStones = goState.board.allStones()

        for (boardPoint, boardStone) in boardStones {
            let gridStone = GridStone(type: boardStone.type, point: gridPoint(from: boardPoint, size: goState.board.size))
            gridStones.append(gridStone)
        }

        return gridStones
    }

    func gridPoint(from move: BoardPoint, size: BoardSize) -> GridPoint {
        let row = size.height - move.row
        let col = move.column + 1
        return GridPoint(row: row, col: col)
    }
}
