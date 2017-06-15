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

    var currentType: StoneNode.StoneType = .black

    override func didMove(to _: SKView) {
        woodBoard = self.childNode(withName: "WoodBoard") as! SKSpriteNode

        addGrid()
        woodBoard.size = CGSize(width: grid.size.width + size.width * 0.1, height: grid.size.height + size.height * 0.1)

        stoneWorker = StoneWorker(grid: grid, stoneFactory: StoneNodeFactory())
    }

    override func touchesBegan(_ touches: Set<UITouch>, with _: UIEvent?) {
        guard let touch = touches.first,
            let point = grid.point(for: touch.location(in: grid)) else {
            return
        }

        _ = stoneWorker.placeStone(type: currentType, at: point)
        currentType = (currentType == .black) ? .white : .black
        print(point)
    }
}

// MARK: Setup
extension BoardScene {
    func addGrid() {
        let availableSize = CGSize(width: self.size.width * 0.9, height: self.size.height * 0.9)
        grid = GridNode(fittingSize: availableSize, rows: 19, cols: 19)!
        grid.stoneNodeFactory = StoneNodeFactory()
        grid.position = CGPoint(x: 0, y: 0)
        grid.zPosition = woodBoard.zPosition + 1
        addChild(grid)
    }
}
