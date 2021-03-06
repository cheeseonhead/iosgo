//
//  SpeedType.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/25/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox

enum SpeedType: String, UnboxableEnum, Codable {
    case correspondence
    case live
    case blitz
}
