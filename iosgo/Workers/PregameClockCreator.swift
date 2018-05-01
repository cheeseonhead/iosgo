//
//  PregameClockCreator.swift
//  iosgo
//
//  Created by Jeffrey Wu on 2018-04-27.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation

enum PregameClockCreatingError: LocalizedError {
    case nowNotPresent
}

class PregameClockCreator {
    func create(from clock: Clock) throws -> Clock {
        guard let now = clock.now else {
            throw PregameClockCreatingError.nowNotPresent
        }

        var copy = clock

        let thinkTime = (clock.expiration - now) / 1000

        switch clock.playingPlayer() {
        case .black:
            copy.whiteTime = nil
            copy.blackTime = Clock.Time(thinkingTime: thinkTime)
        case .white:
            copy.blackTime = nil
            copy.whiteTime = Clock.Time(thinkingTime: thinkTime)
        }

        return copy
    }
}
