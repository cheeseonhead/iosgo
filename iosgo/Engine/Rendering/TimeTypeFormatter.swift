//
//  TimeTypeFormatter
//  iosgo
//
//  Created by Cheese Onhead on 2018-04-24.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation

class TimeTypeFormatter {
    func string(from time: Clock.Time, type: TimeControlType) -> String? {
        switch type {
        case .byoyomi:
            return byoyomiFormat(time)
        case .pregame:
            return pregameFormat(time)
        default:
            return "Not yet implemented"
        }
    }
}

private extension TimeTypeFormatter {
    func pregameFormat(_ time: Clock.Time) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = .abbreviated

        let format = NSLocalizedString("Time to make first move: %@", comment: "")
        let timeString = formatter.string(from: time.thinkingTime)!

        return String(format: format, timeString)
    }

    func byoyomiFormat(_ time: Clock.Time) -> String? {
        guard let periodTime = time.periodTime,
            let periods = time.periods else {
            return nil
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
