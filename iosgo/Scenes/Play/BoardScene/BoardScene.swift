//
//  BoardScene.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/10/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import SpriteKit

class BoardScene: SKScene {
    override func didMove(to _: SKView) {
        if let grid = GridNode(gridSize: self.size, rows: 19, cols: 19) {
            grid.position = CGPoint(x: 0, y: 0)
            addChild(grid)
        }
    }
}
