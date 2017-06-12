//
//  GridNode.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/10/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import SpriteKit

class GridNode: SKSpriteNode {
    var rows: Int!
    var cols: Int!
    var gridSize: CGSize!

    var verticalSpacing: CGFloat {
        return gridSize.height / CGFloat(rows - 1)
    }
    var horizontalSpacing: CGFloat {
        return gridSize.width / CGFloat(cols - 1)
    }

    convenience init?(gridSize: CGSize, rows: Int, cols: Int) {
        guard let texture = GridNode.gridTexture(gridSize: gridSize, rows: rows, cols: cols) else {
            return nil
        }
        self.init(texture: texture, color: SKColor.clear, size: texture.size())
        self.gridSize = gridSize
        self.rows = rows
        self.cols = cols
    }
}

extension GridNode {
    class func gridTexture(gridSize: CGSize, rows: Int, cols: Int) -> SKTexture? {
        // Add 1 to the height and width to ensure the borders are within the sprite
        UIGraphicsBeginImageContext(gridSize)

        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }

        let bezierPath = UIBezierPath()

        // Draw horizontal lines
        let verticalSpacing = gridSize.height / CGFloat(rows - 1)
        for i in 0 ... rows {
            let y = verticalSpacing * CGFloat(i)
            bezierPath.move(to: CGPoint(x: 0, y: y))
            bezierPath.addLine(to: CGPoint(x: gridSize.width, y: y))
        }

        // Draw vertical lines
        let horizontalSpacing = gridSize.width / CGFloat(cols - 1)
        for i in 0 ... cols {
            let x = horizontalSpacing * CGFloat(i)
            bezierPath.move(to: CGPoint(x: x, y: 0))
            bezierPath.addLine(to: CGPoint(x: x, y: gridSize.height))
        }

        SKColor.white.setStroke()
        bezierPath.lineWidth = 1.0
        bezierPath.stroke()
        context.addPath(bezierPath.cgPath)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return SKTexture(image: image!)
    }
}
