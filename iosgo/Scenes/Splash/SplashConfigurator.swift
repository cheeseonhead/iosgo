//
//  SplashConfigurator.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/4/17.
//  Copyright (c) 2017 Cheeseonhead. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

class SplashConfigurator
{
    static func configure(viewController: SplashViewController)
    {
        let presenter = SplashPresenter()
        presenter.output = viewController

        let interactor = SplashInteractor()
        interactor.output = presenter

        let router = SplashRouter(viewController: viewController, dataProvider: interactor, dataReceiver: interactor)

        viewController.output = interactor
        viewController.router = router
    }
}

extension SplashViewController: SplashPresenterOutput {}

extension SplashInteractor: SplashViewControllerOutput, SplashRouterDataProvider, SplashRouterDataReceiver {}

extension SplashPresenter: SplashInteractorOutput {}
