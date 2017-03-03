//
// Created by Cheese Onhead on 3/1/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox

struct OGSSeekGraphStore
{
    enum ChallengerColorType: String, UnboxableEnum
    {
        case automatic
        case black
        case white
    }

    enum RuleTypes: String, UnboxableEnum
    {
        case japanese
        case chinese
    }

    enum SpeedTypes: String, UnboxableEnum
    {
        case correspondence
    }

    enum TimeControlTypes: String, UnboxableEnum
    {
        case fischer
        case simple
    }

    enum TimeControlParametersType
    {
        case fischer(parameters: Fischer)
        case simple(parameters: Simple)
    }

    struct Challenge
    {
        var username: String
        var timePerMove: Int
        var userId: Int
        var name: String
        var width: Int
        var height: Int
        var handicap: Int
        var challengeId: Int
        var pro: Int
        var maxRank: Int
        var minRank: Int
        var disableAnalysis: Bool
        var rank: Int
        var rules: RuleTypes
        var timeControl: TimeControlTypes
        var ranked: Bool
        var komi: Float?
        var gameId: Int
        var challengerColor: ChallengerColorType
        var timeControlParameters: TimeControlParametersType
    }

    struct Fischer
    {
        var pauseOnWeekends: Bool
        var speed: SpeedTypes
        var system: TimeControlTypes
        var timeControl: TimeControlTypes

        var initialTime: Int
        var maxTime: Int
        var timeIncrement: Int
    }

    struct Simple
    {
        var pauseOnWeekends: Bool
        var speed: SpeedTypes
        var system: TimeControlTypes
        var timeControl: TimeControlTypes

        var perMove: Int
    }
}