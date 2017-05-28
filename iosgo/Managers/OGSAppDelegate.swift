//
//  OGSAppDelegate.swift
//  iosgo
//
//  Created by Jeffrey Wu on 2017-02-15.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import UIKit

@UIApplicationMain
class OGSAppDelegate: UIResponder, UIApplicationDelegate
{

    var window: UIWindow?
    var configurator: OGSAppConfigurator?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        window = UIWindow(frame: UIScreen.main.bounds)

        configurator = OGSAppConfigurator(session: OGSSession(configuration: OGSBetaConfiguration()))
        configurator!.configureApp()

        let rootVCWorker = OGSRootViewControllerWorker()
        let rootVC = rootVCWorker.rootViewController(for: OGSSessionController.sharedInstance.current)

        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()

        return true
    }
}

// MARK: DIP Conform
extension OGSSession: OGSUserSettingsStoreProtocol {}
