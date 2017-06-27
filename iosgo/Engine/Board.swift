//
//  Board.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/26/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation

struct Board {

    private var board = [BoardPoint: Stone]()

    mutating func place(stone: Stone, at point: BoardPoint) {
        board[point] = stone
    }
}
