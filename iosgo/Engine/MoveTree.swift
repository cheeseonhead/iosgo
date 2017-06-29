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
    private static var layoutDirty = false

    var id: Int
    var point: BoardPoint
    weak var engine: GameEngine!
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

// MARK: Creating
extension MoveTree {

    func createMove(point: BoardPoint, trunk: Bool, edited: Bool, player: PlayerType?, moveNumber: Int, state: State) throws -> MoveTree {

        let m = lookupMove(point: point, player: player, edited: edited)
        var nextMove: MoveTree!
        if m == nil || (!(m?.trunk)! && trunk) {
            nextMove = MoveTree(engine: engine, trunk: trunk, point: point, edited: edited, player: player, moveNumber: moveNumber, parent: self, state: state)
        } else {
            nextMove = m!
            nextMove.state = state
            nextMove.moveNumber = moveNumber
            return nextMove
        }

        MoveTree.layoutDirty = true

        if trunk {
            if !self.trunk {
                throw GameError.generic(message: "Attempted trunk move made on non-trunk")
            }

            if self.trunkNext != nil {
                nextMove = self.trunkNext
                nextMove.edited = edited
                nextMove.moveNumber = moveNumber
                nextMove.state = state
                nextMove.point = point
                nextMove.player = player
            } else {
                self.trunkNext = nextMove
            }

            /* Join any branches that may have already been describing this move */
            for (i, branch) in branches.enumerated().reversed() {
                if branch.point == point && branch.player == player {
                    let subBranches = branch.branches

                    for subBranch in subBranches {
                        subBranch.parent = self.trunkNext
                        self.trunkNext?.branches.append(subBranch)
                    }

                    self.branches.remove(at: i)
                    break
                }
            }
        }

        return nextMove
    }

    func lookupMove(point: BoardPoint, player: PlayerType?, edited: Bool) -> MoveTree? {
        if let trunkNext = trunkNext, trunkNext.point == point, trunkNext.edited == edited, (!edited || trunkNext.player != nil) {
            return trunkNext
        }

        for branch in branches {
            if branch.point == point, (!edited || branch.player == player), branch.edited == edited {
                return branch
            }
        }

        return nil
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

    func index(_ idx: Int) -> MoveTree {
        var cur = self
        var index = idx
        while let previous = cur.previous(), index < 0 {
            cur = previous
            index += 1
        }
        while let next = cur.next(), index > 0 {
            cur = next
            index -= 1
        }
        return cur
    }
}
