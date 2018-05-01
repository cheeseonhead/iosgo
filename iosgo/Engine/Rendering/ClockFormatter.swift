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
        
//        guard let now = clock.now else {
//            throw ParseError.propertiesMissingValue([\Clock.now])
//        }
        
//        let seconds = (clock.expiration - now) / 1000
//
//        let blackPlaying = clock.playingPlayer() == .black
//        let black = try string(from: time(from: seconds, originalTime: clock.blackTime, playing: blackPlaying))
//        let white = try string(from: time(from: seconds, originalTime: clock.whiteTime, playing: !blackPlaying))
//
//        return (black, white)
        return ("", "")
    }
}

// MARK: - Create time from seconds left
private extension ClockFormatter {
}

// MARK: - Format Clock

private extension ClockFormatter {
//    func pregameFormat(_ clock: Clock) throws -> (black: String, white: String) {
//        switch clock.playingPlayer() {
//        case .black:
//            return (try pregameString(clock), NSLocalizedString("Waiting...", comment: ""))
//        case .white:
//            return (NSLocalizedString("Waiting...", comment: ""), try pregameString(clock))
//        }
//    }

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
            return try pregameFormat(time)
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
    
    func pregameFormat(_ time: Clock.Time) throws -> String {
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
