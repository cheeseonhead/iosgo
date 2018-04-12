//
//  GridState.swift
//  iosgo
//
//  Created by Cheese Onhead on 7/2/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation

struct GridState {
    var blackPrisoners: Int
    var whitePrisoners: Int
    var stoneType: StoneType
    var size: BoardSize
    var stones: [BoardPoint: GridStone]
}
