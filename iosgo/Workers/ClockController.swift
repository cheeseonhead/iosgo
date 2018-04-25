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

    weak var delegate: ClockControllerDelegate?

    private var clock: Clock
    private var lastTime = Date()

    init(clock: Clock, currentPlayer _: PlayerType) {
        self.clock = clock
    }

    func setClock(_ clock: Clock, currentPlayer _: PlayerType) {
        self.clock = clock
        lastTime = Date()
    }

    func countDownClocks(timePassed: TimeInterval) {
        clock.blackTime?.countDown(timePassed: timePassed)
        clock.whiteTime?.countDown(timePassed: timePassed)
    }

    func updateClock() {
        delegate?.clockUpdated(clock)
    }

    func countDownLoop() {
        var lastTime = Date()
        delay(1) { [weak self] in
            let now = Date()
            self?.countDownClocks(timePassed: now.timeIntervalSince(lastTime))
            lastTime = now

            self?.updateClock()

            self?.countDownLoop()
        }
    }
}
