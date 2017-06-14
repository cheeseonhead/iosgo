//
//  StoneNode.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/12/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import SpriteKit

class StoneNode: SKSpriteNode {
    enum StoneType {
        case black
        case white
    }

    convenience init?(type: StoneType, size: CGSize) {
        switch type {
        case .black:
            self.init(texture: SKTexture(image: #imageLiteral(resourceName: "BlackStone")), color: UIColor.clear, size: size)
        case .white:
            self.init(texture: SKTexture(image: #imageLiteral(resourceName: "WhiteStone")), color: UIColor.clear, size: size)
        }
    }
}