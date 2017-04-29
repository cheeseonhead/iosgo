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
    var socketManager: OGSSocketManager! { set get }

    func connect()
}

class OGSChooseGameListGamesWorker: OGSListGamesStoreDelegate
{
    weak var delegate: OGSChooseGameListGamesWorkerDelegate?
    var seekGraphStore: OGSListGamesStoreProtocol!

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

    func listChallenges(_ challenges: [OGSChallenge])
    {
        let response = OGSChooseGame.ListGames.Response(username: "Jeff", userRank: 4, challenges: challenges)
        delegate?.sendListGamesResponse(response)
    }
}
