//
//  MoveTree.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/28/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class MoveTree {

    private static var moveTreeId = 0

    var id: Int
    var point: BoardPoint
    weak var engine: GameEngine?
    var trunk: Bool
    var edited: Bool
    var player: PlayerType?
    weak var parent: MoveTree?
    var moveNumber: Int
    var state: State

    var label: Any?
    var labelMetrics: Any?
    var layoutX = 0
    var layoutY = 0
    var trunkNext: Any?
    var branches = [MoveTree]()
    var activePathNumber = 0
    var activeNodeNumber = 0
    var autoMark: Any?
    //    var lineColor
    var text = ""
    var correctAnswer: Any?
    var wrongAnswer: Any?

    init(engine: GameEngine, trunk: Bool = true, point: BoardPoint = BoardPoint(row: -1, column: -1), edited: Bool = false, player: PlayerType? = nil, moveNumber: Int = 0, parent: MoveTree? = nil, state: State) {

        MoveTree.moveTreeId += 1
        self.id = MoveTree.moveTreeId
        self.point = point
        self.engine = engine
        self.trunk = trunk
        self.edited = edited
        self.player = player
        self.parent = parent
        self.moveNumber = moveNumber
        self.state = state
    }
}
