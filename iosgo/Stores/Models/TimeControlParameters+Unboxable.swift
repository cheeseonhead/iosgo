//
//  TimeControlParameters+Unboxable.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/24/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox

extension TimeControlParametersType.Fischer: Unboxable {
    init(unboxer: Unboxer) throws {
        pauseOnWeekends = try unboxer.unbox(key: "pause_on_weekends")
        speed = try unboxer.unbox(key: "speed")
        system = try unboxer.unbox(key: "system")
        timeControl = try unboxer.unbox(key: "time_control")

        initialTime = try unboxer.unbox(key: "initial_time")
        maxTime = try unboxer.unbox(key: "max_time")
        timeIncrement = try unboxer.unbox(key: "time_increment")
    }
}

extension TimeControlParametersType.Simple: Unboxable {
    init(unboxer: Unboxer) throws {
        pauseOnWeekends = try unboxer.unbox(key: "pause_on_weekends")
        speed = try unboxer.unbox(key: "speed")
        system = try unboxer.unbox(key: "system")
        timeControl = try unboxer.unbox(key: "time_control")

        timePerMove = try unboxer.unbox(key: "per_move")
    }
}

extension TimeControlParametersType.Byoyomi: Unboxable {
    init(unboxer: Unboxer) throws {
        pauseOnWeekends = try unboxer.unbox(key: "pause_on_weekends")
        speed = try unboxer.unbox(key: "speed")
        system = try unboxer.unbox(key: "system")
        timeControl = try unboxer.unbox(key: "time_control")

        mainTime = try unboxer.unbox(key: "main_time")
        periodTime = try unboxer.unbox(key: "period_time")
        periodCount = try unboxer.unbox(key: "periods")
    }
}

extension TimeControlParametersType.Canadian: Unboxable {
    init(unboxer: Unboxer) throws {
        pauseOnWeekends = try unboxer.unbox(key: "pause_on_weekends")
        speed = try unboxer.unbox(key: "speed")
        system = try unboxer.unbox(key: "system")
        timeControl = try unboxer.unbox(key: "time_control")

        mainTime = try unboxer.unbox(key: "main_time")
        periodTime = try unboxer.unbox(key: "period_time")
        stonesPerPeriod = try unboxer.unbox(key: "stones_per_period")
    }
}

extension TimeControlParametersType.Absolute: Unboxable {
    init(unboxer: Unboxer) throws {
        pauseOnWeekends = try unboxer.unbox(key: "pause_on_weekends")
        speed = try unboxer.unbox(key: "speed")
        system = try unboxer.unbox(key: "system")
        timeControl = try unboxer.unbox(key: "time_control")

        totalTime = try unboxer.unbox(key: "total_time")
    }
}

extension TimeControlParametersType.None: Unboxable {
    init(unboxer: Unboxer) throws {
        pauseOnWeekends = try unboxer.unbox(key: "pause_on_weekends")
        speed = try unboxer.unbox(key: "speed")
        system = try unboxer.unbox(key: "system")
        timeControl = try unboxer.unbox(key: "time_control")
    }
}
