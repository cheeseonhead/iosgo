//
//  BoardScene.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/10/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import SpriteKit

class BoardScene: SKScene {
    var woodBoard: SKSpriteNode!
    var grid: SKSpriteNode!

    override func didMove(to _: SKView) {
        woodBoard = self.childNode(withName: "WoodBoard") as! SKSpriteNode

        addGrid()

        woodBoard.size = CGSize(width: grid.size.width + size.width * 0.1, height: grid.size.height + size.height * 0.1)
    }
}

// MARK: Setup
extension BoardScene {
    func addGrid() {
        let availableSize = CGSize(width: self.size.width * 0.9, height: self.size.height * 0.9)
        grid = GridNode(fittingSize: availableSize, rows: 5, cols: 9)
        grid.position = CGPoint(x: 0, y: 0)

        addChild(grid)
    }
}
