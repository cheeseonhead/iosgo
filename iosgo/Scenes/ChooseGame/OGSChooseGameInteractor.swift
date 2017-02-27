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
    func listGame(request: OGSChooseGame.ListGames.Request)
}

protocol OGSChooseGameInteractorOutput
{
}

class OGSChooseGameInteractor: OGSChooseGameInteractorInput
{
    var output: OGSChooseGameInteractorOutput!
    var listGamesWorker: OGSChooseGameListGamesWorker!

    // MARK: - Business logic

    func listGame(request _: OGSChooseGame.ListGames.Request)
    {

    }
}
