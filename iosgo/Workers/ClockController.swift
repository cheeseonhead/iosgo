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
    private weak var timer: Timer?

    init(clock: Clock, type: TimeControlType) {
        gameClock = clock
        self.type = type

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] timer in
            guard self != nil else {
                timer.invalidate()
                return
            }
            self?.updateLoop()
        })
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

        updateLoop()
    }

    func currentType() -> TimeControlType {
        return type
    }

    func updateLoop() {
        let now = Date()
        countDownClocks(secondsPassed: now.timeIntervalSince(lastTime))
        lastTime = now

        updateClock()
    }
}

private extension ClockController {
    func countDownClocks(secondsPassed: TimeInterval) {
        gameClock = ClockTicker().ticked(gameClock, secondsPassed: secondsPassed, type: type)
    }

    func updateClock() {
        delegate?.clockUpdated(gameClock, type: type)
    }
}
