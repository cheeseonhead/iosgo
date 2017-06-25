//
//  GameEnumerations.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/19/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox

enum TimeControlType: String, UnboxableEnum, Codable {
    case fischer
    case simple
    case byoyomi
    case canadian
    case absolute
    case none
}
