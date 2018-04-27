//
//  ClockTicker.swift
//  iosgo
//
//  Created by Jeffrey Wu on 2018-04-26.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation

class TimeTicker {
    func ticked(_ time: Clock.Time, secondsPassed: TimeInterval, type: TimeControlType) -> Clock.Time {
        switch type {
        case .none:
            fatalError("TimeControlType.none doesn't have Clock.Time object.")
        case .absolute:
            fallthrough
        case .simple:
            fallthrough
        case .canadian:
            fallthrough
        case .pregame:
            fallthrough
        case .fischer:
            return regularTicked(time, secondsPassed: secondsPassed)
        case .byoyomi:
            return byoyomiTicked(time, secondsPassed: secondsPassed)
        }
    }
}

private extension TimeTicker {
    func regularTicked(_ time: Clock.Time, secondsPassed: TimeInterval) -> Clock.Time {
        let remainTime = max(0, time.thinkingTime - secondsPassed)

        return Clock.Time(thinkingTime: remainTime)
    }

    func byoyomiTicked(_ time: Clock.Time, secondsPassed: TimeInterval) -> Clock.Time {
        guard var periodsLeft = time.periods, let periodTime = time.periodTime else {
            fatalError("Byoyomi clock has no proper period properties.")
        }

        var thinkingTime = time.thinkingTime

        if thinkingTime > secondsPassed {
            thinkingTime -= secondsPassed
        } else if periodsLeft >= 1 {
            let overshot = secondsPassed - thinkingTime
            periodsLeft -= 1
            thinkingTime = periodTime - overshot
        } else {
            thinkingTime = 0
        }

        return Clock.Time(thinkingTime: thinkingTime, periods: periodsLeft, periodTime: periodTime)
    }
}
