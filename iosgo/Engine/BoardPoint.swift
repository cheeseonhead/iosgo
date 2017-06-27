//
//  BoardPoint.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/26/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation

// Starts with (0, 0) at the top left of the board
struct BoardPoint: Hashable {
    var row: Int
    var column: Int

    var hashValue: Int {
        return "\(row), \(column)".hashValue
    }

    static func ==(lhs: BoardPoint, rhs: BoardPoint) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
