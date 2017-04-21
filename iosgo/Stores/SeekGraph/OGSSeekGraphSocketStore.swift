//
// Created by Jeffrey Wu on 2017-02-27.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import UIKit
import Unbox
import Starscream
import SocketIO

fileprivate typealias TimeControlParametersType = OGSChallenge.TimeControlParametersType

class OGSSeekGraphSocketStore
{
    weak var delegate: OGSListGamesStoreDelegate?
    let socket = SocketIOClient(socketURL: URL(string: "https://online-go.com")!, config: [.forceWebsockets(true)])

    func connect()
    {
        let challenge = createChallengeFrom(payload: fakeData1())
        delegate?.listChallenges([challenge])

        socket.on("connect")
        { data, ack in
            print("Connected \(data) \(ack)")
            self.socket.emit("seek_graph/connect", ["channel": "global"])
        }

        socket.on("seekgraph/global")
        { data, _ in
            print(data)
        }

        //        ["seek_graph/connect",{"channel":"global"}]

        //        socket.connect()
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
