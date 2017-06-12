//
//  GridNode.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/10/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import SpriteKit

class GridNode: SKSpriteNode {
    private struct Style {
        static var lineWidth: CGFloat = 1.0
        static var stoneSizeRatio: CGFloat = 0.9

        static var offSet: CGFloat {
            return Style.lineWidth
        }
    }

    var rows: Int?
    var cols: Int?
    var gridSize: CGSize?
    var spacing: CGFloat?
    var stoneSize: CGSize {
        guard let spacing = spacing else {
            return CGSize.zero
        }
        return CGSize(width: spacing * Style.stoneSizeRatio, height: spacing * Style.stoneSizeRatio)
    }

    convenience init?(fittingSize: CGSize, rows: Int, cols: Int) {
        guard let texture = GridNode.gridTexture(fittingSize: fittingSize, rows: rows, cols: cols) else {
            return nil
        }
        self.init(texture: texture, color: SKColor.clear, size: texture.size())
        gridSize = texture.size()
        spacing = GridNode.minSpacing(for: fittingSize, rows: rows, cols: cols)
        self.rows = rows
        self.cols = cols
    }

    func stonePosition(row: Int, col: Int) -> CGPoint {
        guard let spacing = spacing else {
            return CGPoint.zero
        }
        let xPos = Style.offSet + CGFloat(col - 1) * spacing
        let yPos = Style.offSet + CGFloat(row - 1) * spacing

        return CGPoint(x: xPos - (size.width / 2), y: yPos - (size.height / 2))
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
            let y = spacing * CGFloat(i) + Style.offSet
            bezierPath.move(to: CGPoint(x: 0, y: y))
            bezierPath.addLine(to: CGPoint(x: gridSize.width, y: y))
        }

        // Draw vertical lines
        for i in 0 ... cols {
            let x = spacing * CGFloat(i) + Style.offSet
            bezierPath.move(to: CGPoint(x: x, y: 0))
            bezierPath.addLine(to: CGPoint(x: x, y: gridSize.height))
        }

        SKColor.black.setStroke()
        bezierPath.lineWidth = Style.lineWidth
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

        return CGSize(width: horizontalLength + 2 * Style.lineWidth, height: verticalLength + 2 * Style.lineWidth)
    }
}
