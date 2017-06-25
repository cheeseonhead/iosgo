//
//  RuleType.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/25/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox

enum RuleType: String, UnboxableEnum, Codable {
    case japanese
    case chinese
    case aga
    case ing
    case korean
    case newZealand = "nz"
}
