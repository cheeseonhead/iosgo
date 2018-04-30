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
    func string(from clock: Clock, type: TimeControlType) throws -> (black: String, white: String) {
        switch type {
        case .pregame:
            return try pregameFormat(clock)
        default:
            break
        }

        let black = try string(from: clock.blackTime, type: type)
        let white = try string(from: clock.whiteTime, type: type)

        return (black, white)
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
    func string(from time: Clock.Time?, type: TimeControlType) throws -> String {
        guard let time = time else {
            return ""
        }

        switch type {
        case .byoyomi:
            return try byoyomiFormat(time)
        case .pregame:
            return "Pregame is not formatted here."
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
