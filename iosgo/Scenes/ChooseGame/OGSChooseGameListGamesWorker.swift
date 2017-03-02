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
    weak var delegate: OGSChooseGameListGamesWorkerDelegate?
    var seekGraphStore: OGSSeekGraphStoreProtocol!

    required init(store: OGSSeekGraphStoreProtocol)
    {
        seekGraphStore = store
        seekGraphStore.delegate = self
    }

    func connect()
    {
        seekGraphStore.connect()
    }

    func listChallenges(_: [OGSSeekGraphStore.Challenge])
    {

    }
}
