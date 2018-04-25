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
            return "\(clock.thinkingTime) + \(clock.periods) x \(clock.periodTime)"
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
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated

        let format = NSLocalizedString("Time to make first move: %@", comment: "")
        let timeString = formatter.string(from: clock.thinkingTime / 1000)!

        return String(format: format, timeString)
    }
}
