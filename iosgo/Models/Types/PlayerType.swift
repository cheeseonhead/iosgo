//
//  PlayerType.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/25/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox

enum PlayerType: String, UnboxableKey, UnboxableEnum, Codable {
    case black, white

    static func transform(unboxedKey: String) -> PlayerType? {
        return PlayerType(rawValue: unboxedKey)
    }
}
