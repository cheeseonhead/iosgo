//
//  TimeTypeFormatter
//  iosgo
//
//  Created by Cheese Onhead on 2018-04-24.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation

enum FormattingError: LocalizedError {
    case propertiesMissingValue(Any.Type, [String])
}

class ClockFormatter {
    func string(from clock: Clock, type: TimeControlType) throws -> (black: String, white: String) {
        let black = try string(from: clock.blackTime, type: type)
        let white = try string(from: clock.whiteTime, type: type)
        
        return (black, white)
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
            return try pregameFormat(time)
        default:
            return "Not yet implemented"
        }
    }
    
    func pregameFormat(_ time: Clock.Time) throws -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = .abbreviated

        let format = NSLocalizedString("Time to make first move: %@", comment: "")
        let timeString = formatter.string(from: time.thinkingTime)!

        return String(format: format, timeString)
    }

    func byoyomiFormat(_ time: Clock.Time) throws -> String {
        guard let periodTime = time.periodTime,
            let periods = time.periods else {
            throw FormattingError.propertiesMissingValue(Clock.Time.self, ["periodTime", "periods"])
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
