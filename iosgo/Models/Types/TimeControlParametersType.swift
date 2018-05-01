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

    init(from json: JSON) throws {
        if let res = try? JSONDecoder().decode(Fischer.self, from: json) {
            self = .fischer(parameters: res)
        } else if let res = try? JSONDecoder().decode(Simple.self, from: json) {
            self = .simple(parameters: res)
        } else if let res = try? JSONDecoder().decode(Byoyomi.self, from: json) {
            self = .byoyomi(parameters: res)
        } else if let res = try? JSONDecoder().decode(Canadian.self, from: json) {
            self = .canadian(parameters: res)
        } else if let res = try? JSONDecoder().decode(Absolute.self, from: json) {
            self = .absolute(parameters: res)
        } else if let res = try? JSONDecoder().decode(None.self, from: json) {
            self = .none(parameters: res)
        } else {
            throw ParseError.unknownEnumType(type: TimeControlParametersType.self)
        }
    }

    init(from string: String) throws {
        guard let data = string.data(using: .utf8),
            let j = try? JSONSerialization.jsonObject(with: data, options: []),
            let json = j as? JSON else {
            throw ParseError.wrongDataFormat(str: string)
        }

        try self.init(from: json)
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.singleValueContainer()

        if let str = try? c.decode(String.self) {
            try self.init(from: str)
        } else {
            let d = try decoder.container(keyedBy: JSONCodingKeys.self)
            let json = try d.decode(JSON.self)
            try self.init(from: json)
        }
    }

    case fischer(parameters: Fischer)
    case simple(parameters: Simple)
    case byoyomi(parameters: Byoyomi)
    case canadian(parameters: Canadian)
    case absolute(parameters: Absolute)
    case none(parameters: None)

    class Parent: Codable {
        var pauseOnWeekends: Bool?
        var speed: SpeedType
        var system: TimeControlType
        var timeControl: TimeControlType

        private enum CodingKeys: String, CodingKey {
            case pauseOnWeekends = "pause_on_weekends"
            case speed
            case system
            case timeControl = "time_control"
        }

        required init(from decoder: Decoder) throws {
            let c = try decoder.container(keyedBy: CodingKeys.self)

            pauseOnWeekends = try c.decode(.pauseOnWeekends)
            speed = try c.decode(.speed)
            system = try c.decode(.system)
            timeControl = try c.decode(.timeControl)
        }
    }

    class Fischer: Parent {

        var initialTime: Int
        var maxTime: Int
        var timeIncrement: Int

        private enum CodingKeys: String, CodingKey {
            case initialTime = "initial_time"
            case maxTime = "max_time"
            case timeIncrement = "time_increment"
        }

        required init(from decoder: Decoder) throws {
            let c = try decoder.container(keyedBy: CodingKeys.self)

            initialTime = try c.decode(.initialTime)
            maxTime = try c.decode(.maxTime)
            timeIncrement = try c.decode(.timeIncrement)

            try super.init(from: decoder)
        }
    }

    class Simple: Parent {
        var timePerMove: Int

        private enum CodingKeys: String, CodingKey {
            case timePerMove = "time_per_move"
        }

        required init(from decoder: Decoder) throws {
            let c = try decoder.container(keyedBy: CodingKeys.self)

            timePerMove = try c.decode(.timePerMove)

            try super.init(from: decoder)
        }
    }

    class Byoyomi: Parent {
        var mainTime: Int
        var periodTime: Int
        var periodCount: Int

        private enum CodingKeys: String, CodingKey {
            case mainTime = "main_time"
            case periodTime = "period_time"
            case periodCount = "periods"
        }

        required init(from decoder: Decoder) throws {
            let c = try decoder.container(keyedBy: CodingKeys.self)

            mainTime = try c.decode(.mainTime)
            periodTime = try c.decode(.periodTime)
            periodCount = try c.decode(.periodCount)

            try super.init(from: decoder)
        }
    }

    class Canadian: Parent {
        var mainTime: Int
        var periodTime: Int
        var stonesPerPeriod: Int

        private enum CodingKeys: String, CodingKey {
            case mainTime = "main_time"
            case periodTime = "period_time"
            case stonesPerPeriod = "stones_per_period"
        }

        required init(from decoder: Decoder) throws {
            let c = try decoder.container(keyedBy: CodingKeys.self)

            mainTime = try c.decode(.mainTime)
            periodTime = try c.decode(.periodTime)
            stonesPerPeriod = try c.decode(.stonesPerPeriod)

            try super.init(from: decoder)
        }
    }

    class Absolute: Parent {
        var totalTime: Int

        private enum CodingKeys: String, CodingKey {
            case totalTime = "total_time"
        }

        required init(from decoder: Decoder) throws {
            let c = try decoder.container(keyedBy: CodingKeys.self)

            totalTime = try c.decode(.totalTime)

            try super.init(from: decoder)
        }
    }

    class None: Parent {
    }
}
