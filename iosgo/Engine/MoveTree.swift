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
    var hintNext: MoveTree?
    var moveNumber: Int
    var state: State

    var label: Any?
    var labelMetrics: Any?
    var layoutX = 0
    var layoutY = 0
    var trunkNext: MoveTree?
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

// MARK: Traversing
extension MoveTree {

    func previous() -> MoveTree? {
        if let parent = parent {
            parent.hintNext = self
        }

        return parent
    }

    func next(dontFollowHints: Bool = false) -> MoveTree? {
        if let hintNext = hintNext, !dontFollowHints {
            /* Remember what branch we were on and follow that by default.. but
             * because we sometimes delete things, we're gonna check to make sure it's
             * still in our list of branches before blindly following it */
            if let trunkNext = trunkNext, hintNext.id == trunkNext.id {
                return hintNext
            }

            for branch in branches {
                if branch.id == hintNext.id {
                    return hintNext
                }
            }
        }

        if let trunkNext = trunkNext {
            return trunkNext
        }
        if branches.count > 0 {
            return branches[0]
        }

        return nil
    }

    //    func index(_ index: Int) -> MoveTree {
    //
    //    }
}
