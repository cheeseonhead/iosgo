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

    func createStone(type: StoneNode.StoneType, size: CGSize) -> StoneNode {
        var stoneNode: StoneNode!

        switch type {
        case .black:
            stoneNode = StoneNode(texture: blackTexture, color: UIColor.clear, size: size)
        case .white:
            stoneNode = StoneNode(texture: whiteTexture, color: UIColor.clear, size: size)
        }

        return stoneNode
    }
}
