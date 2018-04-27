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
    var blackTime: Time?
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
    var whiteTime: Time?

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
    struct Time: Decodable {
        let thinkingTime: Double

        // MARK: Fischer

        let skipBonus: Bool?

        // MARK: Byoyomi

        let periods: Int?
        let periodTime: Double?

        // MARK: Canadian

        let movesLeft: Int?
        let blockTime: Double?

        init(thinkingTime: Double, skipBonus: Bool? = nil, periods: Int? = nil, periodTime: Double? = nil, movesLeft: Int? = nil, blockTime: Double? = nil) {
            self.thinkingTime = thinkingTime
            self.skipBonus = skipBonus
            self.periods = periods
            self.periodTime = periodTime
            self.movesLeft = movesLeft
            self.blockTime = blockTime
        }

        enum CodingKeys: String, CodingKey {
            case thinkingTime = "thinking_time"
            case skipBonus = "skip_bonus"
            case periods
            case periodTime = "period_time"
            case movesLeft = "moves_left"
            case blockTime = "block_time"
        }
    }
}
