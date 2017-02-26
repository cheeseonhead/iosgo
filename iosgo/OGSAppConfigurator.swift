//
// Created by Jeffrey Wu on 2017-02-18.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class OGSAppConfigurator: NSObject
{
    fileprivate var userSetting: OGSUserSettingsProtocol! { didSet { configureApp() } }
    fileprivate var configuration: OGSConfigurationProtocol! { didSet { configureApp() } }

    required init(userSetting: OGSUserSettingsProtocol, configuration: OGSConfigurationProtocol)
    {
        self.userSetting = userSetting
        self.configuration = configuration

        OGSApiManager.sharedInstance.domainName = configuration.domainName
        OGSApiManager.sharedInstance.clientId = configuration.clientID
        OGSApiManager.sharedInstance.clientSecret = configuration.clientSecret

        OGSNotificationCenter.sharedInstance.addObserver(self, selector: #selector(self.handleAccessTokenUpdated), name: .accessTokenUpdated, object: nil)
        OGSNotificationCenter.sharedInstance.addObserver(self, selector: #selector(self.handleRefreshTokenUpdated), name: .refreshTokenUpdated, object: nil)
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
        userSetting.accessToken = accessToken
        guard OGSDiskManager.saveObject(userSetting) else
        {
            fatalError("Failed to save accessToken")
        }
    }

    func setAndSave(refreshToken: String)
    {
        userSetting.refreshToken = refreshToken
        guard OGSDiskManager.saveObject(userSetting) else
        {
            fatalError("Failed to save refreshToken")
        }
    }
}
