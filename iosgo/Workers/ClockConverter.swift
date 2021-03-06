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
class ClockConverter {
    let type: TimeControlType

    required init(type: TimeControlType) {
        self.type = type
    }

    func actualClock(from clock: Clock) -> Clock? {

        guard let now = clock.now else {
            return nil
        }

        var copy = clock

        let seconds = (clock.expiration - now) / 1000

        switch clock.playingPlayer() {
        case .black:
            copy.blackTime = playingPlayerTime(from: seconds, originalTime: clock.blackTime)
            copy.whiteTime = waitingPlayerTime(from: clock.whiteTime)
        case .white:
            copy.blackTime = waitingPlayerTime(from: clock.blackTime)
            copy.whiteTime = playingPlayerTime(from: seconds, originalTime: clock.whiteTime)
        }

        return copy
    }
}

private extension ClockConverter {
    func waitingPlayerTime(from originalTime: Clock.Time?) -> Clock.Time? {
        switch type {
        case .pregame:
            return nil
        default:
            return originalTime
        }
    }

    func playingPlayerTime(from seconds: Double, originalTime: Clock.Time?) -> Clock.Time? {

        guard let time = originalTime else {
            return nil
        }

        switch type {
        case .byoyomi:
            return byoyomiTime(from: seconds, time: time)
        default:
            return regularTime(from: seconds, time: time)
        }
    }

    func regularTime(from seconds: Double, time: Clock.Time) -> Clock.Time {
        var copy = time

        copy.thinkingTime = seconds

        return copy
    }

    func byoyomiTime(from seconds: Double, time: Clock.Time) -> Clock.Time {
        guard let periods = time.periods, let periodTime = time.periodTime else {
            fatalError("periods or periodTime not while trying to convert byoyomi time")
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
