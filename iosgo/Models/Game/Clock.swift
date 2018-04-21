//
//  Clock.swift
//  iosgo
//
//  Created by Jeffrey Wu on 2018-04-21.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation

struct Clock: Decodable {
    struct Time: Decodable {
        let skipBonus: Bool?
        let thinkingTime: Double

        enum CodingKeys: String, CodingKey {
            case skipBonus = "skip_bonus"
            case thinkingTime = "thinking_time"
        }
    }

    let blackId: Int
    let blackTime: Time
    let currentPlayer: Int
    let expiration: Int
    let gameId: Int
    let lastMove: Int
    let now: Int
    let pausedSince: Int?
    let title: String
    let whiteId: Int
    let whiteTime: Time

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
}
