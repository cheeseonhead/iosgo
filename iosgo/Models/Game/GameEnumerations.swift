//
//  GameEnumerations.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/19/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox

enum TimeControlTypes: String, UnboxableEnum, Codable {
    case fischer
    case simple
    case byoyomi
    case canadian
    case absolute
    case none
}

enum RuleTypes: String, UnboxableEnum, Codable {
    case japanese
    case chinese
    case aga
    case ing
    case korean
    case newZealand = "nz"
}

enum SpeedTypes: String, UnboxableEnum, Codable {
    case correspondence
    case live
    case blitz
}
