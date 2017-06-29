//
//  Board.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/26/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation

struct Board {

    var size: BoardSize

    private var board = [BoardPoint: BoardStone]()

    init(size: BoardSize) {
        self.size = size
    }
}

// MARK: - Getters
extension Board {

    func stone(at point: BoardPoint) -> BoardStone? {
        return board[point]
    }
}

// MARK: - Manipulation
extension Board {

    mutating func placeStone(type: StoneType, at point: BoardPoint) {
        let stone = BoardStone(type: type)
        board[point] = stone
    }

    mutating func removeStone(at point: BoardPoint) {
        board.removeValue(forKey: point)
    }
}

// MARK: - Equatable
extension Board: Equatable {
    static func ==(lhs: Board, rhs: Board) -> Bool {
        let points = lhs.board.keys

        for point in points {
            if lhs.stone(at: point) != rhs.stone(at: point) {
                return false
            }
        }

        return true
    }
}
