//
//  Stone.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/25/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation

struct GridStone {
    var type: StoneType
    var point: GridPoint
}

extension GridStone: Equatable {

    static func ==(lhs: GridStone, rhs: GridStone) -> Bool {
        return lhs.type == rhs.type && lhs.point == rhs.point
    }
}
