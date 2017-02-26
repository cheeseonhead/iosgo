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
    }

    func configureApp()
    {
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

fileprivate class Configuration
{
    static var DataName: String = "Configuration"
    static var DataVersion: Int = 1

    var domainName = "https://beta.online-go.com/"
    var clientID = "T0upLgPLIiuDt1zozbgEAqt1Cho3wWDRc2Iw6iJQ"
    var clientSecret = "6YMRzrSCoKYvu5iTxH6cHl8WZUsr5G8pHghsYxc03rHOSsrLSk2fAzPwLvrOItYwixKE1elPAiAmrLH9vkftKCK3KNGxpME67MxazWrIMJ2kE08Yc2foyIcH3IYnfjhk"
}

fileprivate class UserSetting: NSObject, OGSVersionedCoding
{
    static var DataName: String = "UserSetting"
    static var DataVersion: Int = 1

    var accessToken: String?
    var refreshToken: String?

    required convenience init?(coder aDecoder: NSCoder)
    {
        self.init()
        accessToken = aDecoder.decodeObject(forKey: "accessToken") as? String
        refreshToken = aDecoder.decodeObject(forKey: "refreshToken") as? String
    }

    public func encode(with aCoder: NSCoder)
    {
        aCoder.encode(accessToken, forKey: "accessToken")
        aCoder.encode(refreshToken, forKey: "refreshToken")
    }
}
