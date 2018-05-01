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
    
    func string(from clock: Clock?) throws -> (black: String, white: String) {
        
        guard let clock = clock else {
            return ("", "")
        }
        
        let black = try string(from: clock.blackTime)
        let white = try string(from: clock.whiteTime)

        return (black, white)
    }
}

// MARK: - Format Time

private extension ClockFormatter {
    func string(from time: Clock.Time?) throws -> String {
        
        if type == .pregame {
            return try pregameFormat(time)
        }
        
        guard let time = time else {
            return ""
        }
        
        switch type {
        case .byoyomi:
            return try byoyomiFormat(time)
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
    
    func pregameFormat(_ time: Clock.Time?) throws -> String {
        
        guard let time = time else {
            return "Waiting..."
        }
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        
        let format = NSLocalizedString("Time to make first move: %@", comment: "")
        let timeString = formatter.string(from: time.thinkingTime)!
        
        return String(format: format, timeString)
    }

    func getFormatter() -> DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = .abbreviated

        return formatter
    }
}
