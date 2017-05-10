//
// Created by Jeffrey Wu on 2017-05-10.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class OGSUserDefaults: OGSUserSettingsStoreProtocol
{
    enum Key
    {
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
    }

    var userDefault: UserDefaults = UserDefaults.standard

    func save(accessToken: String)
    {
        userDefault.set(accessToken, forKey: Key.accessToken)
    }

    func save(refreshToken: String)
    {
        userDefault.set(refreshToken, forKey: Key.refreshToken)
    }

    func getUserSettings() -> OGSUserSettings
    {
        let settings = OGSUserSettings()
        settings.accessToken = userDefault.string(forKey: Key.accessToken)
        settings.refreshToken = userDefault.string(forKey: Key.refreshToken)

        return settings
    }
}
