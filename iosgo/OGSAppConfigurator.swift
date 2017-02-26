//
// Created by Jeffrey Wu on 2017-02-18.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class OGSAppConfigurator: NSObject
{
    fileprivate var userSettingsStore: OGSUserSettingsStoreProtocol!
    fileprivate var configuration: OGSConfigurationProtocol!

    required init(userSettingsStore: OGSUserSettingsStoreProtocol, configuration: OGSConfigurationProtocol)
    {
        super.init()
        self.userSettingsStore = userSettingsStore
        self.configuration = configuration

        OGSNotificationCenter.sharedInstance.addObserver(self, selector: #selector(self.handleAccessTokenUpdated), name: .accessTokenUpdated, object: nil)
        OGSNotificationCenter.sharedInstance.addObserver(self, selector: #selector(self.handleRefreshTokenUpdated), name: .refreshTokenUpdated, object: nil)
    }

    func configureApp()
    {
        var userSettings = userSettingsStore.getUserSettings()

        OGSApiManager.sharedInstance.accessToken = userSettings.accessToken
        OGSApiManager.sharedInstance.refreshToken = userSettings.refreshToken

        OGSApiManager.sharedInstance.domainName = configuration.domainName
        OGSApiManager.sharedInstance.clientId = configuration.clientID
        OGSApiManager.sharedInstance.clientSecret = configuration.clientSecret
    }
}

// MARK: - Broadcast Handlers
extension OGSAppConfigurator
{
    func handleAccessTokenUpdated(notification: NSNotification)
    {
        guard let accessToken = notification.object as? String else { return }
        OGSApiManager.sharedInstance.accessToken = accessToken

        setAndSave(accessToken: accessToken)
    }

    func handleRefreshTokenUpdated(notification: NSNotification)
    {
        guard let refreshToken = notification.object as? String else { return }
        OGSApiManager.sharedInstance.refreshToken = refreshToken

        setAndSave(refreshToken: refreshToken)
    }
}

// MARK: - Set and Save
fileprivate extension OGSAppConfigurator
{
    func setAndSave(accessToken: String)
    {
        userSettingsStore.save(accessToken: accessToken)
    }

    func setAndSave(refreshToken: String)
    {
        userSettingsStore.save(refreshToken: refreshToken)
    }
}
