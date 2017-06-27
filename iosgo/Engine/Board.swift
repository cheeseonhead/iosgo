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

    private var board = [BoardPoint: Stone]()

    init(size: BoardSize) {
        self.size = size
    }

    mutating func place(stone: Stone, at point: BoardPoint) {
        board[point] = stone
    }
}
