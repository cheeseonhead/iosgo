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

    static func from(timeControl: TimeControlTypes, unboxable: UnboxableDictionary) throws -> TimeControlParametersType {

        let wrapperDict: UnboxableDictionary = ["time_control_parameters": unboxable]
        let unboxer = Unboxer(dictionary: wrapperDict)

        switch timeControl {
        case .fischer:
            let parameters: TimeControlParametersType.Fischer = try unboxer.unbox(key: "time_control_parameters")
            return .fischer(parameters: parameters)
        case .simple:
            let parameters: TimeControlParametersType.Simple = try unboxer.unbox(key: "time_control_parameters")
            return .simple(parameters: parameters)
        case .byoyomi:
            let parameters: TimeControlParametersType.Byoyomi = try unboxer.unbox(key: "time_control_parameters")
            return .byoyomi(parameters: parameters)
        case .canadian:
            let parameters: TimeControlParametersType.Canadian = try unboxer.unbox(key: "time_control_parameters")
            return .canadian(parameters: parameters)
        case .absolute:
            let parameters: TimeControlParametersType.Absolute = try unboxer.unbox(key: "time_control_parameters")
            return .absolute(parameters: parameters)
        case .none:
            let parameters: TimeControlParametersType.None = try unboxer.unbox(key: "time_control_parameters")
            return .none(parameters: parameters)
        }
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
