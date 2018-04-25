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

class ClockController {

    enum Phase {
        case waiting, playing

        init(movesCount: Int) {
            if movesCount == 0 {
                self = .waiting
            } else {
                self = .playing
            }
        }
    }

    weak var delegate: ClockControllerDelegate?

    private var clock: Clock
    private var phase: Phase
    private var lastTime = Date()

    init(clock: Clock, phase: Phase) {
        self.clock = clock
        self.phase = phase
        changeClock(for: phase)
    }

    func setClock(_ clock: Clock, phase: Phase) {
        self.clock = clock
        self.phase = phase

        lastTime = Date()
        changeClock(for: phase)
    }

    func countDownLoop() {
        delay(1) { [weak self] in
            guard let s = self else { return }
            let now = Date()
            s.countDownClocks(millisecondsPassed: now.timeIntervalSince(s.lastTime) * 1000)
            s.lastTime = now

            s.updateClock()

            s.countDownLoop()
        }
    }
}

private extension ClockController {
    func countDownClocks(millisecondsPassed: TimeInterval) {
        switch clock.playingPlayer() {
        case .black:
            clock.blackTime?.countDown(millisecondsPassed: millisecondsPassed)
        case .white:
            clock.whiteTime?.countDown(millisecondsPassed: millisecondsPassed)
        }
    }

    func updateClock() {
        delegate?.clockUpdated(clock)
    }

    func changeClock(for phase: Phase) {
        switch phase {
        case .waiting:
            switch clock.playingPlayer() {
            case .black:
                clock.blackTime = pregameWaitingTime(clock)
                clock.whiteTime = nil
            case .white:
                clock.blackTime = nil
                clock.whiteTime = pregameWaitingTime(clock)
            }
        case .playing:
            return
        }
    }

    func pregameWaitingTime(_ clock: Clock) -> Clock.TimeType {
        guard let now = clock.now else {
            return .pregame(Clock.Pregame(thinkingTime: 600))
        }

        let timeLeft = clock.expiration - now
        return .pregame(Clock.Pregame(thinkingTime: timeLeft))
    }
}
