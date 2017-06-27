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
}
