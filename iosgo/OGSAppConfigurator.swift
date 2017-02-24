//
// Created by Jeffrey Wu on 2017-02-18.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class OGSAppConfigurator
{
// MARK: - Broadcast Handlers
fileprivate extension OGSAppConfigurator
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
        OGSDiskManager.saveObject(userSetting)
    }

    func setAndSave(refreshToken: String)
    {
        userSetting.refreshToken = refreshToken
        OGSDiskManager.saveObject(userSetting)
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

    func configureApp()
    {
        OGSApiManager.sharedInstance.domainName = domainName
        OGSApiManager.sharedInstance.clientId = clientID
        OGSApiManager.sharedInstance.clientSecret = clientSecret
    }
}
