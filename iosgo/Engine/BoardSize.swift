//
//  BoardSize.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/26/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation

struct BoardSize {
    var height: Int
    var width: Int

    func contains(point: BoardPoint) -> Bool {
        guard point.row >= 0 && point.column >= 0 else {
            return false
        }

        guard point.row < height && point.column < width else {
            return false
        }

        return true
    }
}
