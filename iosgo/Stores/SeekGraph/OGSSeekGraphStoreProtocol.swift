//
// Created by Jeffrey Wu on 2017-02-26.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox

struct OGSSeekGraphStore
{
    enum RuleTypes: String, UnboxableEnum
    {
        case japanese
        case chinese
    }

    enum TimeControlTypes: String, UnboxableEnum
    {
        case fischer
    }

    enum ChallengerColorType: String, UnboxableEnum
    {
        case automatic
        case black
        case white
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
    }
}

protocol OGSSeekGraphStoreDelegate: class
{
    func listChallenges(_ challenges: [OGSSeekGraphStore.Challenge])
}

protocol OGSSeekGraphStoreProtocol
{
    weak var delegate: OGSSeekGraphStoreDelegate? { set get }

    func connect()
}
