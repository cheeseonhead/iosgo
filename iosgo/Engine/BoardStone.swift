//
//  BoardStone.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/26/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation

struct BoardStone {
    var type: StoneType
}

extension BoardStone: Equatable {
    static func ==(lhs: BoardStone, rhs: BoardStone) -> Bool {
        return lhs.type == rhs.type
    }
}
