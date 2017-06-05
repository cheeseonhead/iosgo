//
// Created by Jeffrey Wu on 2017-05-10.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

struct OGSSession
{
    enum Key
    {
        static let user = "user"
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
    }

    fileprivate var userDefault: UserDefaults = UserDefaults.standard

    var accessToken: String?
    {
        set
        {
            userDefault.set(newValue, forKey: Key.accessToken)
        }

        get
        {
            return userDefault.string(forKey: Key.accessToken)
        }
    }

    var refreshToken: String?
    {
        set
        {
            userDefault.set(newValue, forKey: Key.refreshToken)
        }

        get
        {
            return userDefault.string(forKey: Key.refreshToken)
        }
    }

    var user: OGSUser?

    var configuration: OGSConfigurationProtocol

    var tokensExists: Bool
    {
        return accessToken != nil && refreshToken != nil
    }

    init(configuration: OGSConfigurationProtocol)
    {
        self.configuration = configuration
    }
}
