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

    convenience init?(fittingSize: CGSize, rows: Int, cols: Int) {
        guard let texture = GridNode.gridTexture(fittingSize: fittingSize, rows: rows, cols: cols) else {
            return nil
        }
        self.init(texture: texture, color: SKColor.clear, size: texture.size())
        self.gridSize = texture.size()
        self.rows = rows
        self.cols = cols
    }
}

extension GridNode {
    class func gridTexture(fittingSize: CGSize, rows: Int, cols: Int) -> SKTexture? {
        let spacing = minSpacing(for: fittingSize, rows: rows, cols: cols)
        let gridSize = size(for: spacing, rows: rows, cols: cols)

        // Add 1 to the height and width to ensure the borders are within the sprite
        UIGraphicsBeginImageContext(gridSize)

        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }

        let bezierPath = UIBezierPath()

        // Draw horizontal lines
        for i in 0 ... rows {
            let y = spacing * CGFloat(i)
            bezierPath.move(to: CGPoint(x: 0, y: y))
            bezierPath.addLine(to: CGPoint(x: gridSize.width, y: y))
        }

        // Draw vertical lines
        for i in 0 ... cols {
            let x = spacing * CGFloat(i)
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

    class func minSpacing(for fittingSize: CGSize, rows: Int, cols: Int) -> CGFloat {
        // Calculate the spacing
        let horizontalSpacing = fittingSize.width / CGFloat(cols - 1)
        let verticalSpacing = fittingSize.height / CGFloat(rows - 1)

        return min(horizontalSpacing, verticalSpacing)
    }

    class func size(for spacing: CGFloat, rows: Int, cols: Int) -> CGSize {
        let horizontalLength = spacing * CGFloat(cols - 1)
        let verticalLength = spacing * CGFloat(rows - 1)

        return CGSize(width: horizontalLength, height: verticalLength)
    }
}
