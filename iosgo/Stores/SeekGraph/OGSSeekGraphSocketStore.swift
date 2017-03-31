//
// Created by Jeffrey Wu on 2017-02-27.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import UIKit
import Unbox
import Starscream

fileprivate typealias TimeControlParametersType = OGSChallenge.TimeControlParametersType

class OGSSeekGraphSocketStore: OGSListGamesStoreProtocol
{
    weak var delegate: OGSListGamesStoreDelegate?
    var socket = WebSocket(url: URL(string: "wss://beta.online-go.com/socket.io/?EIO=3&transport=websocket")!)

    func connect()
    {
        let challenge = self.createChallengeFrom(payload: fakeData1())
        delegate?.listChallenges([challenge])
        
        socket.onConnect = {
            self.socket.write(string: "42[\"seek_graph/connect\",{\"channel\":\"global\"}]")
        }
        
        socket.onText = { (text: String) in
            print("got some text: \(text)")

            print("Turn into dictionary")

            print("\("[{\"test\": 12345}]".convertToDictionary())")

            let startIndex = text.index(text.startIndex, offsetBy: 2)
            let newText = "{\"payload\": \(text.substring(from: startIndex))}"
            print("\(newText.convertToDictionary())")
        }
        
        socket.onData = { (data: Data) in
            print("got some data: \(data.count)")
        }
        
        socket.connect()
    }

    func createChallengeFrom(payload: [String: Any?]) -> OGSChallenge
    {
        do {
            let challenge: OGSChallenge = try unbox(dictionary: payload)
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
            "challenger_color": "automatic",
            "time_control_parameters": [
                "system": "fischer",
                "pause_on_weekends": true,
                "time_control": "fischer",
                "initial_time": 259200,
                "max_time": 604800,
                "time_increment": 86400,
                "speed": "correspondence"
            ]
        ]
    }
}

extension OGSChallenge: Unboxable
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
        self.challengerRank = try unboxer.unbox(key: "rank")
        self.rules = try unboxer.unbox(key: "rules")
        self.timeControl = try unboxer.unbox(key: "time_control")
        self.ranked = try unboxer.unbox(key: "ranked")
        self.minRank = try unboxer.unbox(key: "min_rank")
        self.komi = unboxer.unbox(key: "komi")
        self.gameId = try unboxer.unbox(key: "game_id")
        self.challengerColor = try unboxer.unbox(key: "challenger_color")

        switch timeControl {
        case .fischer:
            let parameters: TimeControlParametersType.Fischer = try unboxer.unbox(key: "time_control_parameters")
            self.timeControlParameters = .fischer(parameters: parameters)
            break
        case .simple:
            let parameters: TimeControlParametersType.Simple = try unboxer.unbox(key: "time_control_parameters")
            self.timeControlParameters = .simple(parameters: parameters)
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

        perMove = try unboxer.unbox(key: "per_move")
    }
}
