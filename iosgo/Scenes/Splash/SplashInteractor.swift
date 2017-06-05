//
//  SplashInteractor.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/4/17.
//  Copyright (c) 2017 Cheeseonhead. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol SplashInteractorInput
{
    func loadScene(request: Splash.LoadScene.Request)
}

protocol SplashInteractorOutput
{
    func presentLoadScene(response: Splash.LoadScene.Response)
}

class SplashInteractor: SplashInteractorInput
{
    var output: SplashInteractorOutput!

    func loadScene()
    {
        //
        //        configurator = OGSAppConfigurator(session: OGSSession(configuration: OGSBetaConfiguration()))
        //        configurator!.configureApp()
        //
        //        let rootVCWorker = OGSRootViewControllerWorker()
        //        let rootVC = rootVCWorker.rootViewController(for: OGSSessionController.sharedInstance.current)
        //
        //        window?.rootViewController = rootVC
        //        window?.makeKeyAndVisible()
    }

    func loadScene(request _: Splash.LoadScene.Request)
    {
    }
}
