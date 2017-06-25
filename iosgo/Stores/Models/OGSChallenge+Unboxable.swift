//
//  OGSChallenge+Unboxable.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/24/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox

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

        let parametersJson = unboxer.dictionary["time_control_parameters"]! as! UnboxableDictionary
        timeControlParameters = try TimeControlParametersFormatter().conditionalUnbox(dictionary: parametersJson)
    }
}
