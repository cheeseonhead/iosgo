//
//  BoardPoint.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/26/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation

/// Starts with (0, 0) at the top left of the board
struct BoardPoint: Codable {
    var row: Int
    var column: Int

    enum Direction {
        case above, below, left, right
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.singleValueContainer()

        if let array = try? c.decode([Int].self) {
            row = array[0]
            column = array[1]
        } else {
            throw ParseError.typeMismatches(expected: [[Int].self], actual: Void.self)
        }
    }

    init(row: Int, column: Int) {
        self.row = row
        self.column = column
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

    func toLetters() -> String {
        let rowC = Character.fromInt(row)
        let colC = Character.fromInt(column)

        return String([colC, rowC]).lowercased()
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
