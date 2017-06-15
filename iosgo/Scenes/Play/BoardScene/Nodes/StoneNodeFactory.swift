//
//  StoneNodeFactory.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/14/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import SpriteKit

class StoneNodeFactory {

    func createStone(type: StoneNode.StoneType, size: CGSize) -> StoneNode {
        var stoneNode: StoneNode!

        switch type {
        case .black:
            stoneNode = StoneNode(texture: SKTexture(image: #imageLiteral(resourceName: "BlackStone")), color: UIColor.clear, size: size)
        case .white:
            stoneNode = StoneNode(texture: SKTexture(image: #imageLiteral(resourceName: "WhiteStone")), color: UIColor.clear, size: size)
        }

        return stoneNode
    }
}
