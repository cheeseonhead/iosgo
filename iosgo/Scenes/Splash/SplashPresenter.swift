//
//  SplashPresenter.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/4/17.
//  Copyright (c) 2017 Cheeseonhead. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol SplashPresenterInput
{
    func presentLoadScene(response: Splash.LoadScene.Response)
}

protocol SplashPresenterOutput: class
{
    func displayLoadScene(viewModel: Splash.LoadScene.ViewModel)
}

class SplashPresenter: SplashPresenterInput
{
    weak var output: SplashPresenterOutput!

    func presentLoadScene(response: Splash.LoadScene.Response)
    {
        var viewModel = Splash.LoadScene.ViewModel(nextSceneType: .login)

        if response.loggedIn
        {
            viewModel.nextSceneType = .lobby
        }

        OGSDispatcher.asyncMain
        {
            self.output.displayLoadScene(viewModel: viewModel)
        }
    }
}
