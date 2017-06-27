//
//  BoardScene.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/10/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import SpriteKit

class BoardScene: SKScene {

    // MARK: Nodes
    var woodBoard: SKSpriteNode!
    var grid: GridNode!

    // MARK: Workers
    var stoneWorker: StoneWorker!

    var currentType: StoneType = .black

    override func didMove(to _: SKView) {
        woodBoard = self.childNode(withName: "WoodBoard") as! SKSpriteNode

        addGrid()
        woodBoard.size = CGSize(width: grid.size.width + grid.spacing!, height: grid.size.height + grid.spacing!)

        stoneWorker = StoneWorker(grid: grid, stoneFactory: StoneNodeFactory())
    }
}

// MARK: - Events
extension BoardScene {

    override func touchesBegan(_ touches: Set<UITouch>, with _: UIEvent?) {
        guard let touch = touches.first,
            let point = grid.point(for: touch.location(in: grid)) else {
            return
        }

        _ = stoneWorker.createGhostStone(type: currentType)
        _ = stoneWorker.moveGhostStone(to: point)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with _: UIEvent?) {
        guard let touch = touches.first,
            let point = grid.point(for: touch.location(in: grid)) else {
            return
        }

        _ = stoneWorker.moveGhostStone(to: point)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with _: UIEvent?) {
        guard let touch = touches.first,
            let point = grid.point(for: touch.location(in: grid)) else {
            return
        }

        _ = stoneWorker.removeGhostStone()

        if !stoneWorker.isOccupied(point: point) {
            _ = stoneWorker.placeStone(type: currentType, at: point)
            currentType = (currentType == .black) ? .white : .black
        }
    }
}

// MARK: - Display
extension BoardScene {

    func placeStones(_ stones: [Stone]) {
        stoneWorker.placeStones(stones)
    }
}

// MARK: Setup
extension BoardScene {
    func addGrid() {
        let rows: CGFloat = 19
        let cols: CGFloat = 19

        let availableWidth = size.width * (cols - 1) / cols
        let availableHeight = size.height * (rows - 1) / rows
        let availableSize = CGSize(width: availableWidth, height: availableHeight)
        grid = GridNode(fittingSize: availableSize, rows: Int(rows), cols: Int(cols))!
        grid.position = CGPoint(x: 0, y: 0)
        grid.zPosition = woodBoard.zPosition + 1
        addChild(grid)
    }
}
