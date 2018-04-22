//
//  TimeControlParameters.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/24/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox

enum TimeControlParametersType: Codable {

    case fischer(parameters: Fischer)
    case simple(parameters: Simple)
    case byoyomi(parameters: Byoyomi)
    case canadian(parameters: Canadian)
    case absolute(parameters: Absolute)
    case none(parameters: None)

    struct Fischer: Codable {
        var pauseOnWeekends: Bool?
        var speed: SpeedType?
        var system: TimeControlType?
        var timeControl: TimeControlType

        var initialTime: Int
        var maxTime: Int
        var timeIncrement: Int
    }

    struct Simple: Codable {
        var pauseOnWeekends: Bool?
        var speed: SpeedType?
        var system: TimeControlType?
        var timeControl: TimeControlType

        var timePerMove: Int
    }

    struct Byoyomi: Codable {
        var pauseOnWeekends: Bool?
        var speed: SpeedType?
        var system: TimeControlType?
        var timeControl: TimeControlType

        var mainTime: Int
        var periodTime: Int
        var periodCount: Int
    }

    struct Canadian: Codable {
        var pauseOnWeekends: Bool?
        var speed: SpeedType?
        var system: TimeControlType?
        var timeControl: TimeControlType

        var mainTime: Int
        var periodTime: Int
        var stonesPerPeriod: Int
    }

    struct Absolute: Codable {
        var pauseOnWeekends: Bool?
        var speed: SpeedType?
        var system: TimeControlType?
        var timeControl: TimeControlType

        var totalTime: Int
    }

    struct None: Codable {
        var pauseOnWeekends: Bool?
        var speed: SpeedType?
        var system: TimeControlType?
        var timeControl: TimeControlType
    }
}
