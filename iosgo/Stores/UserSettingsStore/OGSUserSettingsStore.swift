//
// Created by Jeffrey Wu on 2017-02-26.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class OGSUserSettingsStore: OGSUserSettingsStoreProtocol
{
    fileprivate var userSettings: OGSUserSettings!

    func save(accessToken: String)
    {
        guard userSettings != nil else
        {
            return
        }

        userSettings.accessToken = accessToken
        guard OGSDiskManager.saveObject(userSettings) else
        {
            fatalError("Failed to save accessToken")
        }
    }

    func save(refreshToken: String)
    {
        guard userSettings != nil else
        {
            return
        }

        userSettings.refreshToken = refreshToken
        guard OGSDiskManager.saveObject(userSettings) else
        {
            fatalError("Failed to save refreshToken")
        }
    }

    func getUserSettings() -> OGSUserSettings
    {
        guard userSettings == nil else
        {
            return userSettings
        }

        userSettings = OGSDiskManager.getData(forClass: OGSUserSettings.self)
        if userSettings == nil
        {
            userSettings = OGSUserSettings()
        }
        return userSettings
    }
}
