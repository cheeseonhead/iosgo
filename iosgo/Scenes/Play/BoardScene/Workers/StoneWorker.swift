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

    var ghostStone: StoneNode?

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

    func stone(at point: GridPoint) -> GridStone? {
        guard let node: StoneNode = stoneNodes[point] else {
            return nil
        }
        let gridStone = GridStone(type: node.type, point: point)
        return gridStone
    }
}

// MARK: - Regular Stones
extension StoneWorker {

    func placeStones(_ stones: [GridStone]) {
        for stone in stones {
            _ = placeStone(type: stone.type, at: stone.point)
        }
    }

    func placeStone(type: StoneType, at point: GridPoint) -> Bool {
        if isOccupied(point: point) {
            _ = removeStone(at: point)
        }

        let stone = stoneFactory.createStone(type: type, size: gridNode.stoneSize)
        stoneNodes[point] = stone

        addStoneNode(stone, at: point)

        return true
    }

    func removeStones(at points: [GridPoint]) {

        for point in points {
            _ = removeStone(at: point)
        }
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

// MARK: - Ghost Stone
extension StoneWorker {
    func createGhostStone(type: StoneType) -> Bool {
        guard ghostStone == nil else {
            return false
        }

        let stone = stoneFactory.createGhostStone(type: type, size: gridNode.ghostStoneSize)
        ghostStone = stone

        return true
    }

    func moveGhostStone(to point: GridPoint) -> Bool {
        guard ghostStone != nil else {
            return false
        }

        if isOccupied(point: point) {
            ghostStone?.removeFromParent()
        } else {
            if ghostStone?.parent == nil {
                addStoneNode(ghostStone!, at: point)
            }
            ghostStone?.position = gridNode.stonePosition(for: point)
        }

        return true
    }

    func removeGhostStone() -> Bool {
        guard ghostStone != nil else {
            return false
        }

        ghostStone?.removeFromParent()
        ghostStone = nil

        return true
    }
}

// MARK: - Helpers
private extension StoneWorker {
    func addStoneNode(_ stoneNode: StoneNode, at point: GridPoint) {
        let position = gridNode.stonePosition(for: point)

        stoneNode.position = position
        stoneNode.zPosition = gridNode.zPosition + 1
        gridNode.addChild(stoneNode)
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
