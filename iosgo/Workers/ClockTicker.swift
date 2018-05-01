//
//  TimeTicker
//  iosgo
//
//  Created by Jeffrey Wu on 2018-04-26.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation

class ClockTicker {
    func ticked(_ clock: Clock, secondsPassed: TimeInterval, type: TimeControlType) -> Clock {
        switch type {
        case .none:
            fatalError("TimeControlType.none doesn't have Clock.Time object.")
        case .absolute:
            fallthrough
        case .simple:
            fallthrough
        case .canadian:
            fallthrough
        case .fischer:
            return regularTicked(clock, secondsPassed: secondsPassed, tickMethod: regularTickTime)
        case .byoyomi:
            return regularTicked(clock, secondsPassed: secondsPassed, tickMethod: byoyomiTickTime)
        case .pregame:
            return pregameTicked(clock, secondsPassed: secondsPassed)
        }
    }
}

private extension ClockTicker {
    func regularTicked(_ clock: Clock, secondsPassed _: TimeInterval, tickMethod _: (Clock.Time, TimeInterval) -> Clock.Time) -> Clock {

        guard let now = clock.now else {
            return clock
        }

        var copy = clock
        copy.now = now * 1000

        //        switch clock.playingPlayer() {
        //        case .black:
        //            guard let playerTime = clock.blackTime else { return copy }
        //            copy.blackTime = tickMethod(playerTime, secondsPassed)
        //        case .white:
        //            guard let playerTime = clock.whiteTime else { return copy }
        //            copy.whiteTime = tickMethod(playerTime, secondsPassed)
        //        }

        return copy
    }

    func pregameTicked(_ clock: Clock, secondsPassed: TimeInterval) -> Clock {
        guard let now = clock.now else { return clock }

        var copy = clock

        copy.now = now + secondsPassed * 1000

        return copy
    }
}

// MARK: - Ticking the Time

private extension ClockTicker {
    func regularTickTime(_ time: Clock.Time, secondsPassed: TimeInterval) -> Clock.Time {
        let remainTime = max(0, time.thinkingTime - secondsPassed)

        return Clock.Time(thinkingTime: remainTime)
    }

    func byoyomiTickTime(_ time: Clock.Time, secondsPassed: TimeInterval) -> Clock.Time {
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
