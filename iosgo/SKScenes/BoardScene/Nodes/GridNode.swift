//
//  GridNode.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/10/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import SpriteKit

/// Starts at (1, 1) on the bottom left of the board, different from `BoardPoint`
struct GridPoint {
    var row: Int
    var col: Int

    static let zero = GridPoint(row: -1, col: -1)
}

class GridNode: SKSpriteNode {
    private struct Style {
        static var lineWidth: CGFloat = 1.0
        static var stoneSizeRatio: CGFloat = 0.95

        static var offSet: CGFloat {
            return Style.lineWidth
        }
    }

    // MARK: - Properties

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

    var ghostStoneSize: CGSize {
        return stoneSize.scaled(by: 1.0)
    }

    var stoneNodes = [GridPoint: StoneNode]()

    // MARK: - Object Lifecycle

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

    // MARK: - Usage

    func point(for point: CGPoint) -> GridPoint? {
        guard let spacing = spacing, let rows = rows, let cols = cols else {
            return nil
        }

        let row = point.y.standardizeAndRound(offset: size.height / 2, dividedBy: spacing) + 1
        let col = point.x.standardizeAndRound(offset: size.width / 2, dividedBy: spacing) + 1

        guard case 1 ... rows = row, case 1 ... cols = col else {
            return nil
        }

        return GridPoint(row: row, col: col)
    }

    func stonePosition(for point: GridPoint) -> CGPoint {
        guard let spacing = spacing else {
            return CGPoint.zero
        }
        let xPos = Style.offSet + CGFloat(point.col - 1) * spacing
        let yPos = Style.offSet + CGFloat(point.row - 1) * spacing

        return CGPoint(x: xPos - (size.width / 2), y: yPos - (size.height / 2))
    }
}

// MARK: - Init Helpers

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

    private class func minSpacing(for fittingSize: CGSize, rows: Int, cols: Int) -> CGFloat {
        // Calculate the spacing
        let horizontalSpacing = fittingSize.width / CGFloat(cols - 1)
        let verticalSpacing = fittingSize.height / CGFloat(rows - 1)

        return min(horizontalSpacing, verticalSpacing)
    }

    private class func size(for spacing: CGFloat, rows: Int, cols: Int) -> CGSize {
        let horizontalLength = spacing * CGFloat(cols - 1)
        let verticalLength = spacing * CGFloat(rows - 1)

        return CGSize(width: horizontalLength + 2 * Style.lineWidth, height: verticalLength + 2 * Style.lineWidth)
    }
}
