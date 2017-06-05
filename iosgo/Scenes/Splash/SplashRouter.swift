//
//  SplashRouter.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/4/17.
//  Copyright (c) 2017 Cheeseonhead. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol SplashRouterInput
{
    func navigateToLogin()
    func navigateToLobby()
}

protocol SplashRouterDataProvider: class {}

protocol SplashRouterDataReceiver: class {}

class SplashRouter: SplashRouterInput
{
    weak var viewController: UIViewController!
    private weak var dataProvider: SplashRouterDataProvider!
    weak var dataReceiver: SplashRouterDataReceiver!

    init(viewController: UIViewController, dataProvider: SplashRouterDataProvider, dataReceiver: SplashRouterDataReceiver)
    {
        self.viewController = viewController
        self.dataProvider = dataProvider
        self.dataReceiver = dataReceiver
    }

    func navigateToLogin()
    {
        let nextVC = UIStoryboard(name: "OGSLoginViewController", bundle: nil).instantiateInitialViewController()!
        let transition = OGSRootViewControllerTransition(from: viewController, to: nextVC)

        transition.execute(completion: nil)
    }

    func navigateToLobby()
    {
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
        let transition = OGSRootViewControllerTransition(from: viewController, to: nextVC)

        transition.execute(completion: nil)
    }
}
