//
// Created by Cheese Onhead on 5/27/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class OGSSessionWorker
{
    var sessionController: OGSSessionController
    var current: OGSSession
    {
        return sessionController.current
    }

    required init(sessionController: OGSSessionController)
    {
        self.sessionController = sessionController
    }
}
