//
// Created by Cheese Onhead on 4/20/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

// struct

extension OGSChallenge: Unboxable
{
    init(unboxer: Unboxer) throws
    {
        username = try unboxer.unbox(key: "username")
        name = try unboxer.unbox(key: "name")
        timePerMove = try unboxer.unbox(key: "time_per_move")
        userId = try unboxer.unbox(key: "user_id")
        width = try unboxer.unbox(key: "width")
        height = try unboxer.unbox(key: "height")
        handicap = try unboxer.unbox(key: "handicap")
        challengeId = try unboxer.unbox(key: "challenge_id")
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

        switch timeControl {
        case .fischer:
            let parameters: TimeControlParametersType.Fischer = try unboxer.unbox(key: "time_control_parameters")
            timeControlParameters = .fischer(parameters: parameters)
            break
        case .simple:
            let parameters: TimeControlParametersType.Simple = try unboxer.unbox(key: "time_control_parameters")
            timeControlParameters = .simple(parameters: parameters)
            break
        }
    }
}

extension TimeControlParametersType.Fischer: Unboxable
{
    init(unboxer: Unboxer) throws
    {
        pauseOnWeekends = try unboxer.unbox(key: "pause_on_weekends")
        speed = try unboxer.unbox(key: "speed")
        system = try unboxer.unbox(key: "system")
        timeControl = try unboxer.unbox(key: "time_control")

        initialTime = try unboxer.unbox(key: "initial_time")
        maxTime = try unboxer.unbox(key: "max_time")
        timeIncrement = try unboxer.unbox(key: "time_increment")
    }
}

extension TimeControlParametersType.Simple: Unboxable
{
    init(unboxer: Unboxer) throws
    {
        pauseOnWeekends = try unboxer.unbox(key: "pause_on_weekends")
        speed = try unboxer.unbox(key: "speed")
        system = try unboxer.unbox(key: "system")
        timeControl = try unboxer.unbox(key: "time_control")

        timePerMove = try unboxer.unbox(key: "per_move")
    }
}
