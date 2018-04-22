//
//  TimeControlParameters.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/24/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox

enum TimeControlParametersType: Decodable {

    init(from decoder: Decoder) throws {
        let c = try decoder.singleValueContainer()

        var data: Data!
        if let paramStr = try? c.decode(String.self) {
            guard let d = paramStr.data(using: .utf8) else {
                throw ParseError.wrongDataFormat(str: paramStr)
            }
            data = d
        } else if let dict = try? c.decode(Data.self) {
            data = dict
        } else {
            throw ParseError.typeMismatches(expected: [String.self, Data.self], actual: Void.self)
        }

        if let res = try? JSONDecoder().decode(Fischer.self, from: data) {
            self = .fischer(parameters: res)
        } else if let res = try? JSONDecoder().decode(Simple.self, from: data) {
            self = .simple(parameters: res)
        } else if let res = try? JSONDecoder().decode(Byoyomi.self, from: data) {
            self = .byoyomi(parameters: res)
        } else if let res = try? JSONDecoder().decode(Canadian.self, from: data) {
            self = .canadian(parameters: res)
        } else if let res = try? JSONDecoder().decode(Absolute.self, from: data) {
            self = .absolute(parameters: res)
        } else if let res = try? JSONDecoder().decode(None.self, from: data) {
            self = .none(parameters: res)
        } else {
            throw ParseError.unknownEnumType(type: TimeControlParametersType.self)
        }
    }

    case fischer(parameters: Fischer)
    case simple(parameters: Simple)
    case byoyomi(parameters: Byoyomi)
    case canadian(parameters: Canadian)
    case absolute(parameters: Absolute)
    case none(parameters: None)

    struct Fischer: Codable {
        var pauseOnWeekends: Bool?
        var speed: SpeedType
        var system: TimeControlType
        var timeControl: TimeControlType

        var initialTime: Int
        var maxTime: Int
        var timeIncrement: Int
    }

    struct Simple: Codable {
        var pauseOnWeekends: Bool?
        var speed: SpeedType
        var system: TimeControlType
        var timeControl: TimeControlType

        var timePerMove: Int
    }

    struct Byoyomi: Codable {
        var pauseOnWeekends: Bool?
        var speed: SpeedType
        var system: TimeControlType
        var timeControl: TimeControlType

        var mainTime: Int
        var periodTime: Int
        var periodCount: Int
    }

    struct Canadian: Codable {
        var pauseOnWeekends: Bool?
        var speed: SpeedType
        var system: TimeControlType
        var timeControl: TimeControlType

        var mainTime: Int
        var periodTime: Int
        var stonesPerPeriod: Int
    }

    struct Absolute: Codable {
        var pauseOnWeekends: Bool?
        var speed: SpeedType
        var system: TimeControlType
        var timeControl: TimeControlType

        var totalTime: Int
    }

    struct None: Codable {
        var pauseOnWeekends: Bool?
        var speed: SpeedType
        var system: TimeControlType
        var timeControl: TimeControlType
    }
}
