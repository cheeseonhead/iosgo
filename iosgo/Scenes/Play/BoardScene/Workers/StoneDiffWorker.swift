//
//  StoneDiffWorker.swift
//  iosgo
//
//  Created by Cheese Onhead on 7/2/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class StoneDiffWorker {

    private var stoneWorker: StoneWorker
    private var newState: GridState

    required init(stoneWorker: StoneWorker, newState: GridState) {
        self.stoneWorker = stoneWorker
        self.newState = newState
    }

    func stonesToPlace() -> [GridStone] {

        var stones = [GridStone]()

        for row in 1 ... newState.size.height {
            for col in 1 ... newState.size.width {

                let curPoint = GridPoint(row: row, col: col)
                if newState.stones[curPoint] != stoneWorker.stone(at: curPoint),
                    let stateStone = newState.stones[curPoint] {
                    stones.append(stateStone)
                }
            }
        }

        return stones
    }

    func stonesToRemove() -> [GridPoint] {

        var points = [GridPoint]()

        for row in 1 ... newState.size.height {
            for col in 1 ... newState.size.width {

                let curPoint = GridPoint(row: row, col: col)
                if newState.stones[curPoint] == nil, stoneWorker.isOccupied(point: curPoint) {
                    points.append(curPoint)
                }
            }
        }

        return points
    }
}
