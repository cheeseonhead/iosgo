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
    var grid: GridNode!

    override func didMove(to _: SKView) {
        woodBoard = self.childNode(withName: "WoodBoard") as! SKSpriteNode

        addGrid()

        woodBoard.size = CGSize(width: grid.size.width + size.width * 0.1, height: grid.size.height + size.height * 0.1)

        let pos = grid.stonePosition(row: 13, col: 4)
        let stone: StoneNode! = StoneNode.init(type: .black, size: grid.stoneSize)
        stone.position = pos
        grid.addChild(stone)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with _: UIEvent?) {
        guard let touch = touches.first else {
            return
        }

        let coordinates = grid.point(for: touch.location(in: grid))
        print(coordinates ?? "Not a grid point")
    }
}

// MARK: Setup
extension BoardScene {
    func addGrid() {
        let availableSize = CGSize(width: self.size.width * 0.9, height: self.size.height * 0.9)
        grid = GridNode(fittingSize: availableSize, rows: 19, cols: 19)!
        grid.position = CGPoint(x: 0, y: 0)
        grid.zPosition = woodBoard.zPosition + 1
        addChild(grid)
    }
}
