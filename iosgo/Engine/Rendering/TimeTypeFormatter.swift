//
//  TimeTypeFormatter
//  iosgo
//
//  Created by Cheese Onhead on 2018-04-24.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation

class TimeTypeFormatter {

    func string(from timeType: Clock.TimeType?) -> String {
        guard let timeType = timeType else {
            return ""
        }

        switch timeType {
        case let .byoyomi(clock):
            return byoyomiFormat(clock)
        case let .pregame(clock):
            return pregameFormat(clock)
        default:
            return "Not implementated"
        }
    }
}

private extension TimeTypeFormatter {
    func pregameFormat(_ clock: Clock.Pregame) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = .abbreviated

        let format = NSLocalizedString("Time to make first move: %@", comment: "")
        let timeString = formatter.string(from: clock.thinkingTime)!

        return String(format: format, timeString)
    }

    func byoyomiFormat(_ clock: Clock.Byoyomi) -> String {
        let formatter = getFormatter()

        let format = NSLocalizedString("%@ then %@ x %d", comment: "")
        let mainTime = formatter.string(from: clock.thinkingTime)!
        let periodTime = formatter.string(from: clock.periodTime)!

        return String(format: format, mainTime, periodTime, clock.periods)
    }

    func getFormatter() -> DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = .abbreviated

        return formatter
    }
}
