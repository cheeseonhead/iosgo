//
//  GameData+Clock.swift
//  iosgo
//
//  Created by Cheese Onhead on 2018-04-23.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation
import AssetsLibrary

extension GameData {
    struct Clock: Decodable {

        let blackId: Int
        let blackTime: TimeType?
        let currentPlayer: Int
        let expiration: Int
        let gameId: Int
        let lastMove: Int
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
            case pausedSince = "paused_since"
            case title
            case whiteId = "white_player_id"
            case whiteTime = "white_time"
        }

        init(from decoder: Decoder) throws {
            let c = try decoder.container(keyedBy: CodingKeys.self)

            blackId = try c.decode(.blackId)
            blackTime = try TimeTypeFactory.createTimeType(from: c.decodeIfPresent(JSON.self, forKey: .blackTime))
            currentPlayer = try c.decode(.currentPlayer)
            expiration = try c.decode(.expiration)
            gameId = try c.decode(.gameId)
            lastMove = try c.decode(.lastMove)
            pausedSince = try c.decodeIfPresent(.pausedSince)
            title = try c.decode(.title)
            whiteId = try c.decode(.whiteId)
            whiteTime = try TimeTypeFactory.createTimeType(from: c.decodeIfPresent(JSON.self, forKey: .whiteTime))
        }

        class TimeType {
            let thinkingTime: Double

            init(thinkingTime: Double) {
                self.thinkingTime = thinkingTime
            }

            class Fischer: TimeType, Decodable {
                let skipBonus: Bool

                enum CodingKeys: String, CodingKey {
                    case skipBonus = "skip_bonus"
                    case thinkingTime = "thinking_time"
                }

                required init(from decoder: Decoder) throws {
                    let c = try decoder.container(keyedBy: CodingKeys.self)

                    skipBonus = try c.decode(.skipBonus)
                    super.init(thinkingTime: try c.decode(.thinkingTime))
                }
            }

            class Byoyomi: TimeType, Decodable {
                let periods: Int
                let periodTime: Double

                enum CodingKeys: String, CodingKey {
                    case thinkingTime = "thinking_time"
                    case periods
                    case periodTime = "period_time"
                }

                required init(from decoder: Decoder) throws {
                    let c = try decoder.container(keyedBy: CodingKeys.self)

                    periods = try c.decode(.periods)
                    periodTime = try c.decode(.periodTime)
                    super.init(thinkingTime: try c.decode(.thinkingTime))
                }
            }

            class Simple: TimeType, Decodable {
                required init(from decoder: Decoder) throws {
                    let c = try decoder.singleValueContainer()

                    super.init(thinkingTime: try c.decode(Double.self))
                }
            }

            class Canadian: TimeType, Decodable {
                let movesLeft: Int
                let blockTime: Double

                enum CodingKeys: String, CodingKey {
                    case blockTime = "block_time"
                    case movesLeft = "moves_left"
                    case thinkingTime = "thinking_time"
                }

                required init(from decoder: Decoder) throws {
                    let c = try decoder.container(keyedBy: CodingKeys.self)

                    movesLeft = try c.decode(.movesLeft)
                    blockTime = try c.decode(.blockTime)
                    super.init(thinkingTime: try c.decode(.thinkingTime))
                }
            }

            class Absolute: TimeType, Decodable {
                enum CodingKeys: String, CodingKey {
                    case thinkingTime = "thinking_time"
                }

                required init(from decoder: Decoder) throws {
                    let c = try decoder.container(keyedBy: CodingKeys.self)

                    super.init(thinkingTime: try c.decode(.thinkingTime))
                }
            }
        }

        private class TimeTypeFactory {
            static func createTimeType(from data: JSON?) throws -> TimeType? {

                guard let data = data else {
                    return nil
                }

                let decoder = JSONDecoder()

                if let res = try? decoder.decode(TimeType.Fischer.self, from: data) {
                    return res
                } else if let res = try? decoder.decode(TimeType.Byoyomi.self, from: data) {
                    return res } else if let res = try? decoder.decode(TimeType.Simple.self, from: data) {
                    return res } else if let res = try? decoder.decode(TimeType.Canadian.self, from: data) {
                    return res } else if let res = try? decoder.decode(TimeType.Absolute.self, from: data) {
                    return res } else {
                    throw ParseError.typeMismatches(expected: [TimeType.Fischer.self, TimeType.Byoyomi.self, TimeType.Simple.self, TimeType.Canadian.self, TimeType.Absolute.self], container: data)
                }
            }
        }
    }
}
