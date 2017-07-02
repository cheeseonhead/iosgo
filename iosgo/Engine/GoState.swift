//
//  State.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/28/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation

struct GoState {
    var player: PlayerType
    var boardIsRepeating: Bool
    var whitePrisoners: Int
    var blackPrisoners: Int
    //    var uDataState:
    var board: Board
}

extension GoState: Equatable {

    static func ==(lhs: GoState, rhs: GoState) -> Bool {
        return lhs.board == rhs.board
    }
}
