//
//  ClockController
//  iosgo
//
//  Created by Cheese Onhead on 2018-04-24.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation

protocol ClockControllerDelegate: class {
    func clockUpdated(_ clock: Clock, type: TimeControlType)
}

class ClockController {
    weak var delegate: ClockControllerDelegate?

    private var gameClock: Clock
    private var type: TimeControlType
    private var lastTime = Date()

    init(clock: Clock, type: TimeControlType) {
        gameClock = clock
        self.type = type

        updateClock(currentTime: Date())
    }

    func setGameClock(_ clock: Clock) {
        setGameClock(clock, type: type)
    }

    func setTimeType(_ type: TimeControlType) {
        setGameClock(gameClock, type: type)
    }

    func setGameClock(_ clock: Clock, type: TimeControlType) {
        gameClock = clock
        self.type = type

        updateClock(currentTime: Date())
    }

    func currentType() -> TimeControlType {
        return type
    }

    func countDownLoop() {
        lastTime = Date()
        delay(0.001) { [weak self] in
            guard let s = self else { return }
            let now = Date()
            s.countDownClocks(secondsPassed: now.timeIntervalSince(s.lastTime))

            s.updateClock(currentTime: now)

            s.countDownLoop()
        }
    }
}

private extension ClockController {
    func countDownClocks(secondsPassed: TimeInterval) {
        switch gameClock.playingPlayer() {
        case .black:
            guard let blackTime = gameClock.blackTime else { return }
            gameClock.blackTime = TimeTicker().ticked(blackTime, secondsPassed: secondsPassed, type: type)
        case .white:
            guard let whiteTime = gameClock.whiteTime else { return }
            gameClock.whiteTime = TimeTicker().ticked(whiteTime, secondsPassed: secondsPassed, type: type)
        }
    }

    func updateClock(currentTime: Date) {
        lastTime = currentTime
        delegate?.clockUpdated(gameClock, type: type)
    }
}
