//
// Created by Jeffrey Wu on 2017-05-11.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class OGSSessionController
{
    static let sharedInstance = OGSSessionController(session: OGSSession(configuration: OGSMockConfiguration()))

    var current: OGSSession

    required init(session: OGSSession)
    {
        self.current = session
    }
}

fileprivate class OGSMockConfiguration: OGSConfigurationProtocol
{
    var domainName: String = ""
    var clientID: String = ""
    var clientSecret: String = ""
    var socketAddress: String = ""
}
