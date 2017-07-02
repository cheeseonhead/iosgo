//
//  StoneNodeFactory.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/14/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import SpriteKit

class StoneNodeFactory {

    var blackTexture = SKTexture(image: #imageLiteral(resourceName: "BlackStone"))
    var whiteTexture = SKTexture(image: #imageLiteral(resourceName: "WhiteStone"))

    func createStone(type: StoneType, size: CGSize) -> StoneNode {
        var stoneNode: StoneNode!

        switch type {
        case .black:
            stoneNode = StoneNode(texture: blackTexture, color: UIColor.clear, size: size, type: type)
        case .white:
            stoneNode = StoneNode(texture: whiteTexture, color: UIColor.clear, size: size, type: type)
        }

        return stoneNode
    }

    func createGhostStone(type: StoneType, size: CGSize) -> StoneNode {
        let stoneNode = createStone(type: type, size: size)
        stoneNode.alpha = 0.5

        return stoneNode
    }
}
