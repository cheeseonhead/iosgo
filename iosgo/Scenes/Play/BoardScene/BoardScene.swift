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
    var boardSize = BoardSize.zero

    func initialize(_ state: GridState) {

        woodBoard = self.childNode(withName: "WoodBoard") as! SKSpriteNode

        addGrid(rows: state.size.height, cols: state.size.width)
        woodBoard.size = CGSize(width: grid.size.width + grid.spacing!, height: grid.size.height + grid.spacing!)

        stoneWorker = StoneWorker(grid: grid, stoneFactory: StoneNodeFactory())

        render(state)
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

    func render(_ state: GridState) {
        stoneWorker.placeStones(state.stones)
    }
}

// MARK: Setup
extension BoardScene {
    func addGrid(rows: Int, cols: Int) {
        let rows = CGFloat(rows)
        let cols = CGFloat(cols)

        let availableWidth = size.width * (cols - 1) / cols
        let availableHeight = size.height * (rows - 1) / rows
        let availableSize = CGSize(width: availableWidth, height: availableHeight)
        grid = GridNode(fittingSize: availableSize, rows: Int(rows), cols: Int(cols))!
        grid.position = CGPoint(x: 0, y: 0)
        grid.zPosition = woodBoard.zPosition + 1
        addChild(grid)
    }
}
