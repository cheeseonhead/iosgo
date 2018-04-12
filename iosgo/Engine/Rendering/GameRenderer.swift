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
        let size = goState.board.size
        let stoneType: StoneType = (goState.player == .black) ? .black : .white

        let state = GridState(blackPrisoners: blackPrisoners, whitePrisoners: whitePrisoners, stoneType: stoneType, size: size, stones: gridStones)

        return state
    }
}

// MARK: - Helpers

private extension GameRenderer {
    func getStones(from goState: GoState) -> [GridPoint: GridStone] {
        var gridStones = [GridPoint: GridStone]()
        let boardStones = goState.board.allStones()

        for (boardPoint, boardStone) in boardStones {
            let point = gridPoint(from: boardPoint, size: goState.board.size)
            let gridStone = GridStone(type: boardStone.type, point: point)
            gridStones[point] = gridStone
        }

        return gridStones
    }

    func gridPoint(from move: BoardPoint, size: BoardSize) -> GridPoint {
        let row = size.height - move.row
        let col = move.column + 1
        return GridPoint(row: row, col: col)
    }
}
