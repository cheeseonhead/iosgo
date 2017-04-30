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
    func add(_ newChallenges: [OGSChallenge])
}

protocol OGSListGamesStoreProtocol
{
    weak var delegate: OGSListGamesStoreDelegate? { set get }
    var socketManager: OGSSocketManager! { set get }

    func connect()
}

class OGSChooseGameListGamesWorker: OGSListGamesStoreDelegate
{
    weak var delegate: OGSChooseGameListGamesWorkerDelegate?
    var seekGraphStore: OGSListGamesStoreProtocol!

    fileprivate var challenges: [OGSChallenge] = []

    required init(store: OGSListGamesStoreProtocol)
    {
        seekGraphStore = store
        seekGraphStore.delegate = self
        seekGraphStore.socketManager = OGSSocketManager.sharedInstance
    }

    func connect()
    {
        seekGraphStore.connect()
    }

    func add(_ newChallenges: [OGSChallenge])
    {
        challenges.append(contentsOf: newChallenges)

        let response = OGSChooseGame.ListGames.Response(username: "Jeff", userRank: 4, challenges: challenges)
        delegate?.sendListGamesResponse(response)
    }
}
