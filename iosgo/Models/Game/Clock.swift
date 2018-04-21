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
    let blackTime: TimeType?
    let currentPlayer: Int
    let expiration: Int
    let gameId: Int
    let lastMove: Int
    let now: Int
    let pausedSince: Int?
    let title: String
    let whiteId: Int
    let whiteTime: TimeType?

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

extension Clock {
    enum TimeType: Decodable {
        case fischer(Fischer)
        case simple(Simple)
        case byoyomi(Byoyomi)
        case canadian(Canadian)
        case absolute(Absolute)

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
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Could not decode TimeType \(container).")
            }
        }

        struct Fischer: Decodable {
            let skipBonus: Bool
            let thinkingTime: Double

            enum CodingKeys: String, CodingKey {
                case skipBonus = "skip_bonus"
                case thinkingTime = "thinking_time"
            }
        }

        struct Byoyomi: Decodable {
            let thinkingTime: Double
            let periods: Int
            let periodTime: Double

            enum CodingKeys: String, CodingKey {
                case thinkingTime = "thinking_time"
                case periods
                case periodTime = "period_time"
            }
        }

        typealias Simple = Double

        struct Canadian: Decodable {
            let thinkingTime: Double
            let movesLeft: Int
            let blockTime: Double

            enum CodingKeys: String, CodingKey {
                case blockTime = "block_time"
                case movesLeft = "moves_left"
                case thinkingTime = "thinking_time"
            }
        }

        struct Absolute: Decodable {
            let thinkingTime: Double

            enum CodingKeys: String, CodingKey {
                case thinkingTime = "thinking_time"
            }
        }
    }
}
