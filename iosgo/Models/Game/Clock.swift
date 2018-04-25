//
//  Clock.swift
//  iosgo
//
//  Created by Jeffrey Wu on 2018-04-21.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation

struct Clock: Decodable {
    let blackId: Int
    var blackTime: TimeType?
    let currentPlayer: Int
    /// Expiration in **milliseconds**
    let expiration: Double
    let gameId: Int
    let lastMove: Int
    /// Current time in **milliseconds**
    let now: Double?
    let pausedSince: Double?
    let title: String
    let whiteId: Int
    var whiteTime: TimeType?

    enum CodingKeys: String, CodingKey {
        case blackId = "black_player_id"
        case blackTime = "black_time"
        case currentPlayer = "current_player"
        case expiration
        case gameId = "game_id"
        case lastMove = "last_move"
        case now
        case pausedSince = "paused_since"
        case title
        case whiteId = "white_player_id"
        case whiteTime = "white_time"
    }

    func playingPlayer() -> PlayerType {
        if blackId == currentPlayer {
            return .black
        } else {
            return .white
        }
    }
}

// MARK: - TimeType
extension Clock {
    enum TimeType: Decodable {
        case fischer(Fischer)
        case simple(Simple)
        case byoyomi(Byoyomi)
        case canadian(Canadian)
        case absolute(Absolute)
        case pregame(Pregame)

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()

            if let res = try? container.decode(Fischer.self) {
                self = .fischer(res)
            } else if let res = try? container.decode(Byoyomi.self) {
                self = .byoyomi(res)
            } else if let res = try? container.decode(Simple.self) {
                self = .simple(res)
            } else if let res = try? container.decode(Canadian.self) {
                self = .canadian(res)
            } else if let res = try? container.decode(Absolute.self) {
                self = .absolute(res)
            } else {
                throw ParseError.typeMismatches(expected: [Fischer.self, Byoyomi.self, Simple.self, Canadian.self, Absolute.self], container: container)
            }
        }

        /// - parameter secondsPassed: The time interval in **seconds** that has passed.
        func countDown(secondsPassed: TimeInterval) {
            switch self {
            case let .fischer(tickable):
                tickable.countDown(timePassed: secondsPassed)
            case let .simple(tickable):
                tickable.countDown(timePassed: secondsPassed)
            case let .absolute(tickable):
                tickable.countDown(timePassed: secondsPassed)
            case let .byoyomi(tickable):
                tickable.countDown(timePassed: secondsPassed)
            case let .canadian(tickable):
                tickable.countDown(timePassed: secondsPassed)
            case let .pregame(tickable):
                tickable.countDown(timePassed: secondsPassed)
            }
        }

        func getTickable() -> Tickable {
            switch self {
            case let .fischer(tickable):
                return tickable
            case let .simple(tickable):
                return tickable
            case let .absolute(tickable):
                return tickable
            case let .byoyomi(tickable):
                return tickable
            case let .canadian(tickable):
                return tickable
            case let .pregame(tickable):
                return tickable
            }
        }
    }
}

protocol Tickable {
    mutating func countDown(timePassed: TimeInterval)
}

// MARK: - Different Types
extension Clock {
    class Fischer: Decodable, Tickable {
        let skipBonus: Bool
        var thinkingTime: Double

        enum CodingKeys: String, CodingKey {
            case skipBonus = "skip_bonus"
            case thinkingTime = "thinking_time"
        }

        func countDown(timePassed: TimeInterval) {
            thinkingTime = max(thinkingTime - timePassed, 0)
        }
    }

    class Byoyomi: Decodable, Tickable {
        var thinkingTime: Double
        var periods: Int
        let periodTime: Double

        enum CodingKeys: String, CodingKey {
            case thinkingTime = "thinking_time"
            case periods
            case periodTime = "period_time"
        }

        func countDown(timePassed: TimeInterval) {
            if thinkingTime > timePassed {
                thinkingTime -= timePassed
            } else if periods >= 1 {
                let overshot = timePassed - thinkingTime
                periods -= 1
                thinkingTime = periodTime - overshot
            } else {
                thinkingTime = 0
            }
        }
    }

    class Simple: Decodable, Tickable {
        var thinkingTime: Double

        required init(from decoder: Decoder) throws {
            thinkingTime = try decoder.singleValueContainer().decode(Double.self)
        }

        func countDown(timePassed: TimeInterval) {
            thinkingTime = max(thinkingTime - timePassed, 0)
        }
    }

    class Canadian: Decodable, Tickable {
        var thinkingTime: Double
        let movesLeft: Int
        let blockTime: Double

        enum CodingKeys: String, CodingKey {
            case blockTime = "block_time"
            case movesLeft = "moves_left"
            case thinkingTime = "thinking_time"
        }

        func countDown(timePassed: TimeInterval) {
            thinkingTime = max(thinkingTime - timePassed, 0)
        }
    }

    class Absolute: Decodable, Tickable {
        var thinkingTime: Double

        enum CodingKeys: String, CodingKey {
            case thinkingTime = "thinking_time"
        }

        func countDown(timePassed: TimeInterval) {
            thinkingTime = max(thinkingTime - timePassed, 0)
        }
    }

    class Pregame: Tickable {
        var thinkingTime: Double

        init(thinkingTime: Double) {
            self.thinkingTime = thinkingTime
        }

        func countDown(timePassed: TimeInterval) {
            thinkingTime = max(thinkingTime - timePassed, 0)
        }
    }
}
