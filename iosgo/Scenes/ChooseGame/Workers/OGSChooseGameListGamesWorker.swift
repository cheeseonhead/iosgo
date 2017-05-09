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
    func delete(challengeID: Int)
    func delete(gameID: Int)
}

protocol OGSListGamesStoreProtocol
{
    weak var delegate: OGSListGamesStoreDelegate? { set get }
    var socketManager: OGSSocketManager! { set get }

    func connect()
}

class OGSChooseGameListGamesWorker
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
}
// MARK: Store Delegate
extension OGSChooseGameListGamesWorker: OGSListGamesStoreDelegate
{
    func add(_ newChallenges: [OGSChallenge])
    {
        challenges.append(contentsOf: newChallenges)
        sendResponse()
    }

    func delete(challengeID: Int)
    {
        try? challenges.remove { $0.challengeId == challengeID }
        sendResponse()
    }

    func delete(gameID: Int)
    {
        try? challenges.remove { $0.gameId == gameID }
        sendResponse()
    }

    func sendResponse()
    {
        let response = OGSChooseGame.ListGames.Response(username: "Jeff", userRank: 4, challenges: challenges)
        delegate?.sendListGamesResponse(response)
    }
}
