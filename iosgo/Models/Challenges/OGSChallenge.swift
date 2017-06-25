//
// Created by Jeffrey Wu on 2017-02-28.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Unbox

struct OGSChallenge {
    var username: String
    var challengerRank: Int
    var timePerMove: Int
    var userId: Int
    var name: String
    var width: Int
    var height: Int
    var handicap: Int
    var id: Int
    var pro: Int
    var maxRank: Int
    var minRank: Int
    var disableAnalysis: Bool
    var rules: RuleType
    var timeControl: TimeControlType
    var ranked: Bool
    var komi: Float?
    var gameId: Int
    var challengerColor: ChallengerColorType
    var timeControlParameters: TimeControlParametersType

    enum ChallengerColorType: String, UnboxableEnum {
        case automatic
        case random
        case black
        case white
    }
}

extension OGSChallenge {
    var size: CGSize {
        return CGSize(width: width, height: height)
    }
}
