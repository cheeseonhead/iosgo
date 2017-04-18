//
//  AppDelegate.swift
//  iosgo
//
//  Created by Jeffrey Wu on 2017-02-15.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{

    var window: UIWindow?
    var configurator: OGSAppConfigurator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        // Override point for customization after application launch.

        configurator = OGSAppConfigurator(userSettingsStore: OGSUserSettingsStore(), configuration: OGSProdConfiguration())
        configurator!.configureApp()

        return true
    }
}

// MARK: DIP Conform
extension OGSUserSettingsStore: OGSUserSettingsStoreProtocol {}