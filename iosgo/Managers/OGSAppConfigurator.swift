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
    fileprivate var session: OGSSession

    required init(session: OGSSession)
    {
        self.session = session
        super.init()
    }
}

// MARK: - Configure app
extension OGSAppConfigurator
{
    func configureApp()
    {
        configureSessionController()
        configureApiManager()
        configureSocketManager()
    }

    func configureSessionController()
    {
        OGSSessionController.sharedInstance.current = session
    }

    func configureApiManager()
    {
        OGSApiManager.sharedInstance.accessToken = session.accessToken
        OGSApiManager.sharedInstance.refreshToken = session.refreshToken

        OGSApiManager.sharedInstance.domainName = session.configuration.domainName
        OGSApiManager.sharedInstance.clientId = session.configuration.clientID
        OGSApiManager.sharedInstance.clientSecret = session.configuration.clientSecret
    }

    func configureSocketManager()
    {
        OGSSocketManager.sharedInstance.socketAddress = session.configuration.domainName

        OGSSocketManager.sharedInstance.connect()
    }
}
