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
        switch currentClock.playingPlayer() {
        case .black:
            currentClock.blackTime?.countDown(millisecondsPassed: millisecondsPassed)
        case .white:
            currentClock.whiteTime?.countDown(millisecondsPassed: millisecondsPassed)
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

        let timeLeft = clock.expiration - now
        return .pregame(Clock.Pregame(thinkingTime: timeLeft))
    }
}
