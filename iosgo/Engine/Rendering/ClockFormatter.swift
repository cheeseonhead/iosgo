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

    func string(from clock: Clock?) -> (black: String, white: String) {

        guard let clock = clock else {
            return ("", "")
        }

        let black = string(from: clock.blackTime)
        let white = string(from: clock.whiteTime)

        return (black, white)
    }
}

// MARK: - Format Time

private extension ClockFormatter {
    func string(from time: Clock.Time?) -> String {

        if type == .pregame {
            return pregameFormat(time)
        }

        guard let time = time else {
            return ""
        }

        switch type {
        case .byoyomi:
            return byoyomiFormat(time)
        case .canadian:
            return canadianFormat(time)
        case .fischer:
            fallthrough
        case .absolute:
            fallthrough
        case .pregame:
            fallthrough
        case .simple:
            return regularFormat(time)
        case .none:
            return ""
        }
    }

    func regularFormat(_ time: Clock.Time) -> String {
        let formatter = getFormatter()

        return formatter.string(from: time.thinkingTime.rounded(.toNearestOrAwayFromZero))!
    }

    func byoyomiFormat(_ time: Clock.Time) -> String {
        guard let periodTime = time.periodTime,
            let periods = time.periods else {
            fatalError("periodTime or periods is nil while using formatting byoyomi.")
        }

        let formatter = getFormatter()

        let format = NSLocalizedString("%@ then %d x %@", comment: "")
        let mainTime = formatter.string(from: time.thinkingTime.rounded(.toNearestOrAwayFromZero))!
        let pdTime = formatter.string(from: periodTime)!

        return String(format: format, mainTime, periods, pdTime)
    }

    func pregameFormat(_ time: Clock.Time?) -> String {

        guard let time = time else {
            return "Waiting..."
        }

        let formatter = getFormatter()

        let format = NSLocalizedString("First move: %@", comment: "")
        let timeString = formatter.string(from: time.thinkingTime.rounded(.toNearestOrAwayFromZero))!

        return String(format: format, timeString)
    }

    func canadianFormat(_ time: Clock.Time) -> String {
        guard let movesLeft = time.movesLeft else {
            fatalError("movesLeft is nil")
        }

        let formatter = getFormatter()

        let format = NSLocalizedString("%@ for %d stones", comment: "")
        let mainTime = formatter.string(from: time.thinkingTime.rounded(.toNearestOrAwayFromZero))!

        return String(format: format, mainTime, movesLeft)
    }

    func getFormatter() -> DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = .abbreviated

        return formatter
    }
}
