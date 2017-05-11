//
// Created by Jeffrey Wu on 2017-05-10.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class OGSUserDefaults
{
    enum Key
    {
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
    }

    fileprivate var userDefault: UserDefaults = UserDefaults.standard

    var accessToken: String?
    {
        set
        {
            userDefault.set(accessToken, forKey: Key.accessToken)
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
            userDefault.set(refreshToken, forKey: Key.refreshToken)
        }

        get
        {
            return userDefault.string(forKey: Key.refreshToken)
        }
    }
}
