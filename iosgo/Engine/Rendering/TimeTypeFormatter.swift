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
        default:
            return "Not implementated"
        }
    }
}
