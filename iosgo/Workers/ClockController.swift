//
//  ClockController
//  iosgo
//
//  Created by Cheese Onhead on 2018-04-24.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation

protocol ClockControllerDelegate: class {
    func clockUpdated(_ clock: Clock)
}

/// A controller that takes in a clock object and calls delegate on clock updates.
///
/// It's the owner's responsibility to update the internal clock as this class has no concept of network calls.
///
/// It's possible to change the clock type midway, the controller is capable of counting down any clocks.
class ClockController {
    weak var delegate: ClockControllerDelegate?

    private var currentClock: Clock
    private var type: TimeControlType
    private var lastTime = Date()

    init(clock: Clock, type: TimeControlType) {
        currentClock = clock
        self.type = type
    }

    func setClock(_ clock: Clock) {
        currentClock = clock

        lastTime = Date()
        updateClock()
    }

    func countDownLoop() {
        lastTime = Date()
        delay(0.001) { [weak self] in
            guard let s = self else { return }
            let now = Date()
            s.countDownClocks(secondsPassed: now.timeIntervalSince(s.lastTime))
            s.lastTime = now

            s.updateClock()

            s.countDownLoop()
        }
    }
}

private extension ClockController {
    func countDownClocks(secondsPassed: TimeInterval) {
        switch currentClock.playingPlayer() {
        case .black:
            guard let blackTime = currentClock.blackTime else { return }
            currentClock.blackTime = TimeTicker().ticked(blackTime, secondsPassed: secondsPassed, type: type)
        case .white:
            guard let whiteTime = currentClock.whiteTime else { return }
            currentClock.whiteTime = TimeTicker().ticked(whiteTime, secondsPassed: secondsPassed, type: type)
        }
    }

    func updateClock() {
        delegate?.clockUpdated(currentClock)
    }
}
