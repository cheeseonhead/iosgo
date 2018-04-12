//
//  BoardPoint.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/26/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation

// Starts with (0, 0) at the top left of the board
struct BoardPoint: Codable {
    var row: Int
    var column: Int

    enum Direction {
        case above, below, left, right
    }

    func point(at direction: Direction) -> BoardPoint {
        switch direction {
        case .above:
            return BoardPoint(row: row - 1, column: column)
        case .below:
            return BoardPoint(row: row + 1, column: column)
        case .left:
            return BoardPoint(row: row, column: column - 1)
        case .right:
            return BoardPoint(row: row, column: column + 1)
        }
    }
}

extension BoardPoint: Hashable {
    var hashValue: Int {
        return "\(row), \(column)".hashValue
    }

    static func == (lhs: BoardPoint, rhs: BoardPoint) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
