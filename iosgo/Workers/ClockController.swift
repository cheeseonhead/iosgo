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

    private var currentClock: Clock
    private var gameClock: Clock
    private var phase: Phase
    private var lastTime = Date()

    init(clock: Clock, phase: Phase) {
        gameClock = clock
        currentClock = gameClock
        self.phase = phase
        changePhase(phase)
    }

    func setClock(_ clock: Clock, phase: Phase) {
        gameClock = clock
        currentClock = gameClock
        self.phase = phase

        lastTime = Date()
        changePhase(phase)
    }

    func changePhase(_ phase: Phase) {
        changeClock(for: phase)
    }

    func countDownLoop() {
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
            currentClock.blackTime?.countDown(secondsPassed: secondsPassed)
        case .white:
            currentClock.whiteTime?.countDown(secondsPassed: secondsPassed)
        }
    }

    func updateClock() {
        delegate?.clockUpdated(currentClock)
    }

    func changeClock(for phase: Phase) {
        switch phase {
        case .waiting:
            switch currentClock.playingPlayer() {
            case .black:
                currentClock.blackTime = pregameWaitingTime(currentClock)
                currentClock.whiteTime = nil
            case .white:
                currentClock.blackTime = nil
                currentClock.whiteTime = pregameWaitingTime(currentClock)
            }
        case .playing:
            currentClock = gameClock
        }

        updateClock()
    }

    func pregameWaitingTime(_ clock: Clock) -> Clock.TimeType {
        guard let now = clock.now else {
            return .pregame(Clock.Pregame(thinkingTime: 600))
        }

        let timeLeft = (clock.expiration - now) / 1000
        return .pregame(Clock.Pregame(thinkingTime: timeLeft))
    }
}
