//
//  GameEnumerations.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/19/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox

enum TimeControlParametersType {
    //    init(from decoder: Decoder) throws {
    //
    //    }
    //
    //    func encode(to encoder: Encoder) throws {
    //        <#code#>
    //    }

    case fischer(parameters: Fischer)
    case simple(parameters: Simple)
    case byoyomi(parameters: Byoyomi)
    case canadian(parameters: Canadian)
    case absolute(parameters: Absolute)
    case none(parameters: None)

    struct Fischer: Codable {
        var pauseOnWeekends: Bool
        var speed: SpeedTypes
        var system: TimeControlTypes
        var timeControl: TimeControlTypes

        var initialTime: Int
        var maxTime: Int
        var timeIncrement: Int
    }

    struct Simple: Codable {
        var pauseOnWeekends: Bool
        var speed: SpeedTypes
        var system: TimeControlTypes
        var timeControl: TimeControlTypes

        var timePerMove: Int
    }

    struct Byoyomi: Codable {
        var pauseOnWeekends: Bool
        var speed: SpeedTypes
        var system: TimeControlTypes
        var timeControl: TimeControlTypes

        var mainTime: Int
        var periodTime: Int
        var periodCount: Int
    }

    struct Canadian: Codable {
        var pauseOnWeekends: Bool
        var speed: SpeedTypes
        var system: TimeControlTypes
        var timeControl: TimeControlTypes

        var mainTime: Int
        var periodTime: Int
        var stonesPerPeriod: Int
    }

    struct Absolute: Codable {
        var pauseOnWeekends: Bool
        var speed: SpeedTypes
        var system: TimeControlTypes
        var timeControl: TimeControlTypes

        var totalTime: Int
    }

    struct None: Codable {
        var pauseOnWeekends: Bool
        var speed: SpeedTypes
        var system: TimeControlTypes
        var timeControl: TimeControlTypes
    }
}

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
