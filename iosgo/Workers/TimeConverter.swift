//
//  TimeConverter.swift
//  iosgo
//
//  Created by Cheese Onhead on 2018-04-30.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation

/// Given a **Clock**, **TimeConverter** will return a new **Clock** object
/// corresponding to the actual situation of the players' times.
///
/// This is due to the **Clock** object given by the server not accurately
/// calculating the remaining times. So we have to derive it from **now** and
/// **expiration** properties.
class TimeConverter {
    let type: TimeControlType
    
    required init(type: TimeControlType) {
        self.type = type
    }
    
    func time(from seconds: Double, originalTime: Clock.Time?) throws -> Clock.Time? {
        
        guard let time = originalTime else {
            return nil
        }
        
        switch type {
        case .byoyomi:
            return try byoyomiTime(from: seconds, time: time)
        default:
            return regularTime(from: seconds)
        }
    }
    
    func regularTime(from seconds: Double) -> Clock.Time {
        return Clock.Time(thinkingTime: seconds)
    }
    
    func byoyomiTime(from seconds: Double, time: Clock.Time) throws -> Clock.Time {
        guard let periods = time.periods, let periodTime = time.periodTime else {
            throw ParseError.propertiesMissingValue([\Clock.Time.periods, \Clock.Time.periodTime])
        }
        
        var periodsLeft = 0
        var timeLeft = seconds
        while periodsLeft < periods && timeLeft > periodTime {
            periodsLeft += 1
            timeLeft -= periodTime
        }
        
        return Clock.Time(thinkingTime: timeLeft, periods: periodsLeft, periodTime: periodTime)
    }
}
