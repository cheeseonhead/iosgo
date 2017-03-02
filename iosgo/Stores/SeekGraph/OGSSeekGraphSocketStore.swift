//
// Created by Jeffrey Wu on 2017-02-27.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox


class OGSSeekGraphSocketStore: OGSSeekGraphStoreProtocol
{
    weak var delegate: OGSSeekGraphStoreDelegate?

    func connect()
    {
    }

    func createChallengeFrom(payload: [String: Any?]) -> OGSSeekGraphStore.Challenge
    {
        do {
            let challenge: OGSSeekGraphStore.Challenge = try unbox(dictionary: payload)
            return challenge
        }
        catch _ {
            fatalError("Unable to parse Challenge")
        }
    }

    func fakeData1() -> [String: Any?]
    {
        return [
            "username": "sousys",
            "time_per_move": 89280,
            "user_id": 157,
            "name": "Friendly Match",
            "width": 19,
            "handicap": -1,
            "challenge_id": 767,
            "pro": 0,
            "max_rank": 3,
            "disable_analysis": false,
            "rank": 0,
            "height": 19,
            "rules": "japanese",
            "time_control": "fischer",
            "ranked": true,
            "min_rank": -3,
            "komi": nil,
            "game_id": 809,
            "challenger_color": "automatic"
        ]
    }
}

extension OGSSeekGraphStore.Challenge: Unboxable
{
    init(unboxer: Unboxer) throws
    {
        self.username = try unboxer.unbox(key: "username")
        self.name = try unboxer.unbox(key: "name")
        self.timePerMove = try unboxer.unbox(key: "time_per_move")
        self.userId = try unboxer.unbox(key: "user_id")
        self.width = try unboxer.unbox(key: "width")
        self.height = try unboxer.unbox(key: "height")
        self.handicap = try unboxer.unbox(key: "handicap")
        self.challengeId = try unboxer.unbox(key: "challenge_id")
        self.pro = try unboxer.unbox(key: "pro")
        self.maxRank = try unboxer.unbox(key: "max_rank")
        self.disableAnalysis = try unboxer.unbox(key: "disable_analysis")
        self.rank = try unboxer.unbox(key: "rank")
        self.rules = try unboxer.unbox(key: "rules")
        self.timeControl = try unboxer.unbox(key: "time_control")
        self.ranked = try unboxer.unbox(key: "ranked")
        self.minRank = try unboxer.unbox(key: "min_rank")
        self.komi = unboxer.unbox(key: "komi")
        self.gameId = try unboxer.unbox(key: "game_id")
        self.challengerColor = try unboxer.unbox(key: "challenger_color")
    }
}