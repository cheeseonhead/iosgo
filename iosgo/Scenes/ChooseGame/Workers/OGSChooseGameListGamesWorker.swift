//
// Created by Jeffrey Wu on 2017-02-26.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import UIKit

protocol OGSChooseGameListGamesWorkerDelegate: class
{
    func sendListGamesResponse(_ response: OGSChooseGame.ListGames.Response)
}

protocol OGSListGamesStoreDelegate: class
{
    func listChallenges(_ challenges: [OGSChallenge])
}

protocol OGSListGamesStoreProtocol
{
    weak var delegate: OGSListGamesStoreDelegate? { set get }

    func connect()
}

class OGSChooseGameListGamesWorker: OGSListGamesStoreDelegate
{
    typealias ListGames = OGSChooseGame.ListGames

    weak var delegate: OGSChooseGameListGamesWorkerDelegate?
    var seekGraphStore: OGSListGamesStoreProtocol!

    required init(store: OGSListGamesStoreProtocol)
    {
        seekGraphStore = store
        seekGraphStore.delegate = self
    }

    func connect()
    {
        seekGraphStore.connect()
    }

    func listChallenges(_ challenges: [OGSChallenge])
    {
        let challengeList = createResponseChallengeList(from: challenges)

        let response = OGSChooseGame.ListGames.Response(username: "Jeff", userRank: 4, challenges: challengeList)
        delegate?.sendListGamesResponse(response)
    }
}

fileprivate extension OGSChooseGameListGamesWorker
{
    func createResponseChallengeList(from challengesList: [OGSChallenge]) -> [ListGames.Response.Challenge]
    {
        var responseChallengeList: [ListGames.Response.Challenge] = []

        for apiChallenge in challengesList {
            let username = apiChallenge.username
            let challengerRank = apiChallenge.challengerRank
            let minRank = apiChallenge.minRank
            let maxRank = apiChallenge.maxRank
            let size = CGSize(width: apiChallenge.width, height: apiChallenge.height)
            let timeControlParameters = createResponseTimeParameterType(from: apiChallenge.timeControlParameters)

            let challenge = ListGames.Response.Challenge(challengerUsername: username, challengerRank: challengerRank,
                    minRank: minRank, maxRank: maxRank, size: size, timeControlParameters: timeControlParameters)
            responseChallengeList.append(challenge)
        }

        return responseChallengeList
    }

    typealias ApiTimeControlType = OGSChallenge.TimeControlParametersType
    typealias ResponseTimControlType = ListGames.Response.Challenge.TimeControlParametersType

    func createResponseTimeParameterType(from parameterType: ApiTimeControlType) -> ResponseTimControlType
    {
        switch parameterType {
            case .fischer(let parameters):
                let fischer = ResponseTimControlType.Fischer(initialTime: parameters.initialTime,
                        maxTime: parameters.maxTime, timeIncrement: parameters.timeIncrement)
                return .fischer(parameters: fischer)
            case .simple(let parameters):
                let simple = ResponseTimControlType.Simple(timePerMove: parameters.perMove)
                return .simple(parameters: simple)
        }
    }
}
