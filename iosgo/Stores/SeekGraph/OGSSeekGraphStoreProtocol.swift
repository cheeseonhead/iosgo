//
// Created by Jeffrey Wu on 2017-02-26.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

enum NetworkBool: Int
{
    case YES = 0
    case NO = 1
}

struct OGSSeekGraphStore
{
    enum RuleTypes: String
    {
        case japanese
        case chinese
    }

    enum TimeControlTypes: String
    {
        case fischer
    }

    enum ChallengerColorType: String
    {
        case automatic
    }

    struct Challenge
    {
        var username: String?
        var timePerMove: Int?
        var userId: Int?
        var name: String?
        var width: Int?
        var height: Int?
        var handicap: Int?
        var challengeId: Int?
        var pro: NetworkBool?
        var maxRank: Int?
        var minRank: Int?
        var disableAnalysis: NetworkBool?
        var rank: Int?
        var rules: RuleTypes?
        var timeControl: TimeControlTypes?
        var ranked: NetworkBool?
        var komi: Float?
        var gameId: Int?
        var challengerColor: ChallengerColorType?
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
