//
//  OGSChooseGameInteractor.swift
//  iosgo
//
//  Created by Jeffrey Wu on 2017-02-26.
//  Copyright (c) 2017 Cheeseonhead. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol OGSChooseGameInteractorInput
{
    func listGames(request: OGSChooseGame.ListGames.Request)
}

protocol OGSChooseGameInteractorOutput
{
    func presentListGames(response: OGSChooseGame.ListGames.Response)
}

class OGSChooseGameInteractor: OGSChooseGameInteractorInput
{
    var output: OGSChooseGameInteractorOutput!
    var listGamesWorker = OGSChooseGameListGamesWorker(store: OGSSeekGraphSocketStore())
    var sessionWorker = OGSSessionWorker(sessionController: OGSSessionController.sharedInstance)

    required init()
    {
        listGamesWorker.delegate = self
    }

    func listGames(request _: OGSChooseGame.ListGames.Request)
    {
        listGamesWorker.connect()
    }
}

extension OGSChooseGameInteractor: OGSChooseGameListGamesWorkerDelegate
{
    func sendGameList(_ gameList: [OGSChallenge])
    {
        let session = sessionWorker.current
        let response = OGSChooseGame.ListGames.Response(loggedIn: session.authenticated, username: session.user?.username ?? "",
                                                        userRank: session.user?.rank ?? 0, challenges: gameList)

        output.presentListGames(response: response)
    }
}

// MARK: DIP Conformance
extension OGSSeekGraphSocketStore: OGSListGamesStoreProtocol {}
