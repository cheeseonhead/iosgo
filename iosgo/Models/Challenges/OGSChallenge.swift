//
// Created by Jeffrey Wu on 2017-02-28.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Unbox

struct OGSChallenge
{
    var username: String
    var challengerRank: Int
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
    var rules: RuleTypes
    var timeControl: TimeControlTypes
    var ranked: Bool
    var komi: Float?
    var gameId: Int
    var challengerColor: ChallengerColorType
    var timeControlParameters: TimeControlParametersType

    enum ChallengerColorType: String, UnboxableEnum
    {
        case automatic
        case black
        case white
    }

    enum TimeControlParametersType
    {
        case fischer(parameters: Fischer)
        case simple(parameters: Simple)
        case byoyomi(parameters: Byoyomi)
        case canadian(parameters: Canadian)
        case absolute(parameters: Absolute)

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

            var timePerMove: Int
        }

        struct Byoyomi
        {
            var pauseOnWeekends: Bool
            var speed: SpeedTypes
            var system: TimeControlTypes
            var timeControl: TimeControlTypes

            var mainTime: Int
            var periodTime: Int
            var periodCount: Int
        }

        struct Canadian
        {
            var pauseOnWeekends: Bool
            var speed: SpeedTypes
            var system: TimeControlTypes
            var timeControl: TimeControlTypes

            var mainTime: Int
            var periodTime: Int
            var stonePerPeriod: Int
        }

        struct Absolute
        {
            var pauseOnWeekends: Bool
            var speed: SpeedTypes
            var system: TimeControlTypes
            var timeControl: TimeControlTypes

            var totalTime: Int
        }
    }

    enum TimeControlTypes: String, UnboxableEnum
    {
        case fischer
        case simple
        case byoyomi
        case canadian
        case absolute
    }

    enum RuleTypes: String, UnboxableEnum
    {
        case japanese
        case chinese
    }

    enum SpeedTypes: String, UnboxableEnum
    {
        case correspondence
        case live
    }
}

extension OGSChallenge
{
    var size: CGSize
    {
        return CGSize(width: width, height: height)
    }
}
