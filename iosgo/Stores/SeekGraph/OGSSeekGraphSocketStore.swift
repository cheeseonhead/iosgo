//
// Created by Jeffrey Wu on 2017-02-27.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import UIKit
import Unbox
import Starscream

fileprivate typealias TimeControlParametersType = OGSChallenge.TimeControlParametersType

class OGSSeekGraphSocketStore
{
    enum ModelType
    {
        case challenge
        case gameStarted
        case deleteChallenge
    }

    weak var delegate: OGSListGamesStoreDelegate?
    var socketManager: OGSSocketManager!

    func connect()
    {
        let challenge = createChallengeFrom(payload: fakeData1())
        delegate?.listChallenges([challenge])

        socketManager.on(event: .seekGraphGlobal)
        { _ in
            print("Hello")
        }

        socketManager.emit(event: .seekGraphConnect, with: ["channel": "global"])
    }

    func createChallengeFrom(payload: [String: Any]) -> OGSChallenge
    {
        do
        {
            let challenge: OGSChallenge = try unbox(dictionary: payload)
            return challenge
        }
        catch _
        {
            fatalError("Unable to parse Challenge")
        }
    }

    func fakeData1() -> [String: Any]
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
            //            "komi": nil,
            "game_id": 809,
            "challenger_color": "automatic",
            "time_control_parameters": [
                "system": "fischer",
                "pause_on_weekends": true,
                "time_control": "fischer",
                "initial_time": 259_200,
                "max_time": 604_800,
                "time_increment": 86400,
                "speed": "correspondence",
            ],
        ]
    }
}
