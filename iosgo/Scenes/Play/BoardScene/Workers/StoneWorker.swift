//
//  StoneWorker.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/14/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import SpriteKit

class StoneWorker {

    var gridNode: GridNode
    var stoneFactory: StoneNodeFactory

    init(grid: GridNode, stoneFactory: StoneNodeFactory) {
        gridnode = grid
        self.stoneFactory = stoneFactory
    }
}
