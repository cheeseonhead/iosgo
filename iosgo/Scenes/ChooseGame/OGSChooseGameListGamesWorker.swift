//
// Created by Jeffrey Wu on 2017-02-26.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

protocol OGSChooseGameListGamesWorkerDelegate: class
{
    func sendListGamesResponse(_ response: OGSChooseGame.ListGames.Response)
}

class OGSChooseGameListGamesWorker: OGSSeekGraphStoreDelegate
{
    typealias ListGames = OGSChooseGame.ListGames

    weak var delegate: OGSChooseGameListGamesWorkerDelegate?
    var seekGraphStore: OGSSeekGraphStoreProtocol!

    required init(store: OGSSeekGraphStoreProtocol)
    {
        seekGraphStore = store
        seekGraphStore.delegate = self
    }

    typealias TimeControlParamType = ListGames.Response.Challenge.TimeControlParametersType

    func connect()
    {
        let fischer = TimeControlParamType.Fischer(initialTime: 518400, maxTime: 604800, timeIncrement: 86400)
        let param1: TimeControlParamType = .fischer(parameters: fischer)

        let simple = TimeControlParamType.Simple(timePerMove: 1000000)
        let param2: TimeControlParamType = .simple(parameters: simple)
        let game1 = ListGames.Response.Challenge(challengerUsername: "Jeff", challengerRank: 4, minRank: 0, maxRank: 30, width: 19, height: 19, timeControlParameters: param1)
        let game2 = ListGames.Response.Challenge(challengerUsername: "testss", challengerRank: 16, minRank: 10, maxRank: 30, width: 9, height: 9, timeControlParameters: param2)
        let game3 = ListGames.Response.Challenge(challengerUsername: "JustRight", challengerRank: 16, minRank: 4, maxRank: 10, width: 13, height: 24, timeControlParameters: param2)

        let challengeList = [game1, game2, game3, game1, game2, game3, game1, game2, game3, game1, game2, game3, game1, game2, game3]

        let response = OGSChooseGame.ListGames.Response(username: "Jeff", userRank: 4, challenges: challengeList)
        delegate?.sendListGamesResponse(response)

        seekGraphStore.connect()
    }

    func listChallenges(_: [OGSChallenge])
    {

    }
}
