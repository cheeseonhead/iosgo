//
// Created by Cheese Onhead on 4/20/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox

struct OGSSeekGraphSocketStoreModel {
    typealias Challenge = OGSChallenge

    struct GameStart: Unboxable {
        var blackPlayer: Player
        var whitePlayer: Player
        var gameId: Int
        var gameStarted: Bool
        var timeControl: TimeControlTypes
        var timeControlParameters: TimeControlParametersType

        init(unboxer: Unboxer) throws {
            blackPlayer = try unboxer.unbox(key: "black")
            whitePlayer = try unboxer.unbox(key: "white")
            gameId = try unboxer.unbox(key: "game_id")
            gameStarted = try unboxer.unbox(key: "game_started")
            timeControl = try unboxer.unbox(key: "time_control")

            let formatter = TimeControlParametersFormatter()
            timeControlParameters = try unboxer.unbox(key: "time_control_parameters", formatter: formatter)
        }

        struct Player: Unboxable {
            var country: String
            var id: Int
            var ranking: Int
            var username: String

            init(unboxer: Unboxer) throws {
                username = try unboxer.unbox(key: "username")
                id = try unboxer.unbox(key: "id")
                ranking = try unboxer.unbox(key: "ranking")
                country = try unboxer.unbox(key: "country")
            }
        }
    }

    struct ChallengeDelete: Unboxable {
        var challengeId: Int
        var delete: Bool

        init(unboxer: Unboxer) throws {
            challengeId = try unboxer.unbox(key: "challenge_id")
            delete = try unboxer.unbox(key: "delete")
        }
    }
}
