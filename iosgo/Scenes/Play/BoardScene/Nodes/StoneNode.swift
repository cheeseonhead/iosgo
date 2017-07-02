//
//  StoneNode.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/12/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import SpriteKit

class StoneNode: SKSpriteNode {

    var type: StoneType

    required init(texture: SKTexture?, color: UIColor, size: CGSize, type: StoneType) {
        self.type = type
        super.init(texture: texture, color: color, size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
