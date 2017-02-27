//
// Created by Jeffrey Wu on 2017-02-26.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

protocol OGSChooseGameSocketOutput
{
    func listGame(request: OGSChooseGame.ListGames.Request)
}

class OGSChooseGameSocket
{
    var output: OGSChooseGameSocketOutput!
}
