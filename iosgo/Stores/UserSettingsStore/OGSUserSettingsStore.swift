//
// Created by Jeffrey Wu on 2017-02-26.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class OGSUserSettingsStore
{
    fileprivate lazy var userSettings: OGSUserSettings = self.retrieveUserSettings()

    func save(accessToken: String)
    {
        userSettings.accessToken = accessToken
        guard OGSDiskManager.saveObject(userSettings) else
        {
            fatalError("Failed to save accessToken")
        }
    }

    func save(refreshToken: String)
    {
        userSettings.refreshToken = refreshToken
        guard OGSDiskManager.saveObject(userSettings) else
        {
            fatalError("Failed to save refreshToken")
        }
    }

    func getUserSettings() -> OGSUserSettingsProtocol
    {
        return userSettings
    }
}

fileprivate extension OGSUserSettingsStore
{
    func retrieveUserSettings() -> OGSUserSettings
    {
        guard let oldUserSettings = OGSDiskManager.getData(forClass: OGSUserSettings.self) else
        {
            return OGSUserSettings()
        }

        return oldUserSettings
    }
}
