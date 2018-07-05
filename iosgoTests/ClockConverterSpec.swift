//
//  ClockConverterTests.swift
//  iosgoTests
//
//  Created by Cheese Onhead on 2018-05-01.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import iosgo

class ClockConverterSpec: QuickSpec {
    override func spec() {
        describe("a ClockConverter") {
            var target: ClockConverter!

            context("of type pregame") {
                var clock: Clock!
                var waitingPlayerTime: Clock.Time!

                beforeEach {
                    waitingPlayerTime = MockClockTimeCreator.make(thinkingTime: 1000)
                    target = ClockConverter(type: .pregame)
                }

                context("with black playing") {

                    beforeEach {
                        clock = MockClockCreator.make(blackId: 0, blackTime: waitingPlayerTime, currentPlayer: 0, expiration: 5000, now: 0, whiteId: 1, whiteTime: waitingPlayerTime)
                    }

                    it("has correct black time") {
                        let res = target.actualClock(from: clock)

                        expect(res?.blackTime?.thinkingTime).to(equal(5))
                    }

                    it("has correct white time") {
                        let res = target.actualClock(from: clock)

                        expect(res?.whiteTime?.thinkingTime).to(beNil())
                    }
                }

                context("with white playing") {
                    beforeEach {
                        clock = MockClockCreator.make(blackId: 0, blackTime: waitingPlayerTime, currentPlayer: 1, expiration: 5000, now: 0, whiteId: 1, whiteTime: waitingPlayerTime)
                    }

                    it("has correct black time") {
                        let res = target.actualClock(from: clock)

                        expect(res?.blackTime?.thinkingTime).to(beNil())
                    }

                    it("has correct white time") {
                        let res = target.actualClock(from: clock)

                        expect(res?.whiteTime?.thinkingTime).to(equal(5))
                    }
                }
            }

            context("of type byoyomi") {
                var waitingPlayerTime: Clock.Time!
                var clock: Clock!

                beforeEach {
                    target = ClockConverter(type: .byoyomi)
                    waitingPlayerTime = MockClockTimeCreator.make(thinkingTime: 1000, periods: 5, periodTime: 30)
                }

                context("with black playing") {

                    beforeEach {
                        clock = MockClockCreator.make(blackId: 0, blackTime: waitingPlayerTime, currentPlayer: 0, expiration: 200_000, whiteId: 1, whiteTime: waitingPlayerTime)
                    }

                    it("derived black time correctly") {
                        let res = target.actualClock(from: clock)

                        expect(res?.blackTime?.thinkingTime).to(equal(50))
                        expect(res?.blackTime?.periods).to(equal(5))
                        expect(res?.blackTime?.periodTime).to(equal(30))
                    }

                    it("kept white time") {
                        let res = target.actualClock(from: clock)

                        expect(res?.whiteTime?.thinkingTime).to(equal(waitingPlayerTime.thinkingTime))
                    }

                    context("used some periods") {
                        beforeEach {
                            clock = MockClockCreator.make(blackId: 0, blackTime: waitingPlayerTime, currentPlayer: 0, expiration: 113_000, whiteId: 1, whiteTime: waitingPlayerTime)
                        }

                        it("derived black time correctly") {
                            let res = target.actualClock(from: clock)

                            expect(res?.blackTime?.thinkingTime).to(equal(23))
                            expect(res?.blackTime?.periods).to(equal(3))
                            expect(res?.blackTime?.periodTime).to(equal(30))
                        }
                    }
                }

                context("with white playing") {

                    beforeEach {
                        clock = MockClockCreator.make(blackTime: waitingPlayerTime, currentPlayer: 1, expiration: 200_000, whiteId: 1, whiteTime: waitingPlayerTime)
                    }

                    it("derived white time correctly") {
                        let res = target.actualClock(from: clock)

                        expect(res?.whiteTime?.thinkingTime).to(equal(50))
                        expect(res?.whiteTime?.periods).to(equal(5))
                        expect(res?.whiteTime?.periodTime).to(equal(30))
                    }

                    it("kept black time") {
                        let res = target.actualClock(from: clock)

                        expect(res?.blackTime?.thinkingTime).to(equal(waitingPlayerTime.thinkingTime))
                    }
                }
            }
        }
    }
}

private class MockClockCreator {
    static func make(blackId: Int = 0, blackTime: Clock.Time? = MockClockTimeCreator.make(), currentPlayer: Int = 0, expiration: Double = 0, gameId: Int = 0, lastMove: Int = 0, now: Double = 0, pausedSince: Double? = nil, title: String = "Test", whiteId: Int = 1, whiteTime: Clock.Time? = MockClockTimeCreator.make()) -> Clock {
        return Clock(blackId: blackId, blackTime: blackTime, currentPlayer: currentPlayer, expiration: expiration, gameId: gameId, lastMove: lastMove, now: now, pausedSince: pausedSince, title: title, whiteId: whiteId, whiteTime: whiteTime)
    }
}

private class MockClockTimeCreator {
    static func make(thinkingTime: Double = 0, skipBonus: Bool? = false, periods: Int? = 0, periodTime: Double? = 0, movesLeft: Int? = 0, blockTime: Double? = 0) -> Clock.Time {
        return Clock.Time(thinkingTime: thinkingTime, skipBonus: skipBonus, periods: periods, periodTime: periodTime, movesLeft: movesLeft, blockTime: blockTime)
    }
}
