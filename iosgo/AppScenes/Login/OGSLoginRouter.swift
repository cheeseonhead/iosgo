//
//  OGSLoginRouter.swift
//  iosgo
//
//  Created by Jeffrey Wu on 2017-02-15.
//  Copyright (c) 2017 Cheeseonhead. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol OGSLoginRouterInput
{
    func navigateToMainScene()
}

protocol OGSLoginRouterDataProvider: class {}

protocol OGSLoginRouterDataReceiver: class {}

class OGSLoginRouter: OGSLoginRouterInput
{
    weak var viewController: UIViewController!
    private weak var dataProvider: OGSLoginRouterDataProvider!
    weak var dataReceiver: OGSLoginRouterDataReceiver!

    init(viewController: UIViewController, dataProvider: OGSLoginRouterDataProvider, dataReceiver: OGSLoginRouterDataReceiver)
    {
        self.viewController = viewController
        self.dataProvider = dataProvider
        self.dataReceiver = dataReceiver
    }

    func navigateToMainScene()
    {
        let vc = UIStoryboard(name: "Splash", bundle: nil).instantiateInitialViewController()!

        let transition = OGSRootViewControllerTransition(from: viewController, to: vc)
        transition.execute(completion: nil)
    }
}