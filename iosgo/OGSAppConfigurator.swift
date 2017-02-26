//
// Created by Jeffrey Wu on 2017-02-18.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class OGSAppConfigurator: NSObject
{
    fileprivate var userSettings: OGSUserSettingsProtocol!
    fileprivate var configuration: OGSConfigurationProtocol!

    func configureApp(userSettings: OGSUserSettingsProtocol, configuration: OGSConfigurationProtocol)
    {
        self.userSettings = userSettings
        self.configuration = configuration

        OGSApiManager.sharedInstance.domainName = configuration.domainName
        OGSApiManager.sharedInstance.clientId = configuration.clientID
        OGSApiManager.sharedInstance.clientSecret = configuration.clientSecret
    }

    func change(configuration: OGSConfigurationProtocol)
    {
        self.configuration = configuration
        configureApp(configuration: self.configuration)
    }

    func change(userSettings: OGSUserSettingsProtocol)
    {
        self.userSettings = userSettings
        configureApp(userSettings: self.userSettings)
    }
}

fileprivate extension OGSAppConfigurator
{
    func configureApp(configuration _: OGSConfigurationProtocol)
    {

    }

    func configureApp(userSettings _: OGSUserSettingsProtocol)
    {

    }
}
