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

            switch timeControl {
            case .fischer:
                let parameters: TimeControlParametersType.Fischer = try unboxer.unbox(key: "time_control_parameters")
                timeControlParameters = .fischer(parameters: parameters)
            case .simple:
                let parameters: TimeControlParametersType.Simple = try unboxer.unbox(key: "time_control_parameters")
                timeControlParameters = .simple(parameters: parameters)
            case .byoyomi:
                let parameters: TimeControlParametersType.Byoyomi = try unboxer.unbox(key: "time_control_parameters")
                timeControlParameters = .byoyomi(parameters: parameters)
            case .canadian:
                let parameters: TimeControlParametersType.Canadian = try unboxer.unbox(key: "time_control_parameters")
                timeControlParameters = .canadian(parameters: parameters)
            case .absolute:
                let parameters: TimeControlParametersType.Absolute = try unboxer.unbox(key: "time_control_parameters")
                timeControlParameters = .absolute(parameters: parameters)
            case .none:
                let parameters: TimeControlParametersType.None = try unboxer.unbox(key: "time_control_parameters")
                timeControlParameters = .none(parameters: parameters)
            }
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

extension OGSChallenge: Unboxable {
    init(unboxer: Unboxer) throws {
        username = try unboxer.unbox(key: "username")
        name = try unboxer.unbox(key: "name")
        timePerMove = try unboxer.unbox(key: "time_per_move")
        userId = try unboxer.unbox(key: "user_id")
        width = try unboxer.unbox(key: "width")
        height = try unboxer.unbox(key: "height")
        handicap = try unboxer.unbox(key: "handicap")
        id = try unboxer.unbox(key: "challenge_id")
        pro = try unboxer.unbox(key: "pro")
        maxRank = try unboxer.unbox(key: "max_rank")
        disableAnalysis = try unboxer.unbox(key: "disable_analysis")
        challengerRank = try unboxer.unbox(key: "rank")
        rules = try unboxer.unbox(key: "rules")
        timeControl = try unboxer.unbox(key: "time_control")
        ranked = try unboxer.unbox(key: "ranked")
        minRank = try unboxer.unbox(key: "min_rank")
        komi = unboxer.unbox(key: "komi")
        gameId = try unboxer.unbox(key: "game_id")
        challengerColor = try unboxer.unbox(key: "challenger_color")

        timeControlParameters = try TimeControlParametersType.from(timeControl: timeControl, unboxable: unboxer.dictionary["time_control_parameters"] as! UnboxableDictionary)
    }
}
