//
// Created by Jeffrey Wu on 2017-02-18.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

protocol OGSUserSettingsStoreProtocol
{
    var accessToken: String? { get set }
    var refreshToken: String? { get set }
}

class OGSAppConfigurator: NSObject
{
    fileprivate var userSettingsStore: OGSUserSettingsStoreProtocol!
    fileprivate var configuration: OGSConfigurationProtocol!

    required init(userSettingsStore: OGSUserSettingsStoreProtocol, configuration: OGSConfigurationProtocol)
    {
        super.init()
        self.userSettingsStore = userSettingsStore
        self.configuration = configuration

        OGSNotificationCenter.sharedInstance.addObserver(self, selector: #selector(handleAccessTokenUpdated), name: .accessTokenUpdated, object: nil)
        OGSNotificationCenter.sharedInstance.addObserver(self, selector: #selector(handleRefreshTokenUpdated), name: .refreshTokenUpdated, object: nil)
    }
}

// MARK: - Configure app
extension OGSAppConfigurator
{
    func configureApp()
    {
        configureApiManager()
        configureSocketManager()
    }

    func configureApiManager()
    {
        OGSApiManager.sharedInstance.accessToken = userSettingsStore.accessToken
        OGSApiManager.sharedInstance.refreshToken = userSettingsStore.refreshToken

        OGSApiManager.sharedInstance.domainName = configuration.domainName
        OGSApiManager.sharedInstance.clientId = configuration.clientID
        OGSApiManager.sharedInstance.clientSecret = configuration.clientSecret
    }

    func configureSocketManager()
    {
        OGSSocketManager.sharedInstance.socketAddress = configuration.domainName

        OGSSocketManager.sharedInstance.connect()
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
        userSettingsStore.accessToken = accessToken
    }

    func setAndSave(refreshToken: String)
    {
        userSettingsStore.refreshToken = refreshToken
    }
}
