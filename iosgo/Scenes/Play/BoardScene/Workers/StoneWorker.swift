//
//  StoneWorker.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/14/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import SpriteKit

class StoneWorker {

    var gridNode: GridNode
    var stoneFactory: StoneNodeFactory

    private var stoneNodes = [GridPoint: StoneNode]()

    init(grid: GridNode, stoneFactory: StoneNodeFactory) {
        gridNode = grid
        self.stoneFactory = stoneFactory
    }
}

// MARK: - Checking
extension StoneWorker {

    func isOccupied(point: GridPoint) -> Bool {
        return stoneNodes[point] != nil
    }
}

// MARK: - Manipulation
extension StoneWorker {
    func placeStone(type: StoneNode.StoneType, at point: GridPoint) -> Bool {
        guard stoneNodes[point] == nil else {
            return false
        }

        let pos = gridNode.stonePosition(for: point)
        let stone = stoneFactory.createStone(type: type, size: gridNode.stoneSize)
        stone.position = pos
        stone.zPosition = gridNode.zPosition + 1
        stoneNodes[point] = stone
        gridNode.addChild(stone)

        return true
    }

    func removeStone(at point: GridPoint) -> Bool {
        guard let stoneNode = stoneNodes[point] else {
            return false
        }

        gridNode.removeChildren(in: [stoneNode])
        stoneNodes.removeValue(forKey: point)

        return true
    }
}

// MARK: - GridPoint Extension
extension GridPoint: Hashable {
    var hashValue: Int {
        return "\(row), \(col)".hashValue
    }

    static func ==(lhs: GridPoint, rhs: GridPoint) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
