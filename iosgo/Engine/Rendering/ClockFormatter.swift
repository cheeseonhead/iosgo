//
//  TimeTypeFormatter
//  iosgo
//
//  Created by Cheese Onhead on 2018-04-24.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation

enum FormattingError: LocalizedError {
    case propertiesMissingValue(Any.Type, [AnyKeyPath])
}

class ClockFormatter {
    
    let type: TimeControlType
    
    required init(type: TimeControlType) {
        self.type = type
    }
    
    func string(from clock: Clock) throws -> (black: String, white: String) {
        
        guard let now = clock.now else {
            throw ParseError.propertiesMissingValue([\Clock.now])
        }
        
        let seconds = (clock.expiration - now) / 1000
        
        let blackPlaying = clock.playingPlayer() == .black
        let black = try string(from: time(from: seconds, time: clock.blackTime, playing: blackPlaying))
        let white = try string(from: time(from: seconds, time: clock.whiteTime, playing: !blackPlaying))

        return (black, white)
    }
}

// MARK: - Create time from seconds left
private extension ClockFormatter {
    
    func time(from seconds: Double, time: Clock.Time?, playing: Bool) throws -> Clock.Time? {
        
        guard let time = time else {
            return nil
        }
        
        switch type {
        case .byoyomi:
            return try byoyomiTime(from: seconds, time: time)
        case .pregame:
            if !playing {
                return nil
            }
            fallthrough
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

// MARK: - Format Clock

private extension ClockFormatter {
    func pregameFormat(_ clock: Clock) throws -> (black: String, white: String) {
        switch clock.playingPlayer() {
        case .black:
            return (try pregameString(clock), NSLocalizedString("Waiting...", comment: ""))
        case .white:
            return (NSLocalizedString("Waiting...", comment: ""), try pregameString(clock))
        }
    }

    func pregameString(_ clock: Clock) throws -> String {
        guard let duration = clock.secondsUntilExpiration() else {
            throw ParseError.propertiesMissingValue([\Clock.now])
        }

        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = .abbreviated

        let format = NSLocalizedString("Time to make first move: %@", comment: "")
        let timeString = formatter.string(from: duration)!

        return String(format: format, timeString)
    }
}

// MARK: - Format Time

private extension ClockFormatter {
    func string(from time: Clock.Time?) throws -> String {
        guard let time = time else {
            return ""
        }

        switch type {
        case .byoyomi:
            return try byoyomiFormat(time)
        case .pregame:
            return "Waiting..."
        default:
            return "Not yet implemented"
        }
    }

    func byoyomiFormat(_ time: Clock.Time) throws -> String {
        guard let periodTime = time.periodTime,
            let periods = time.periods else {
            throw ParseError.propertiesMissingValue([\Clock.Time.periodTime, \Clock.Time.periods])
        }

        let formatter = getFormatter()

        let format = NSLocalizedString("%@ then %@ x %d", comment: "")
        let mainTime = formatter.string(from: time.thinkingTime)!
        let pdTime = formatter.string(from: periodTime)!

        return String(format: format, mainTime, pdTime, periods)
    }

    func getFormatter() -> DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = .abbreviated

        return formatter
    }
}
