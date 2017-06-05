//
//  SplashViewController.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/4/17.
//  Copyright (c) 2017 Cheeseonhead. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol SplashViewControllerInput
{
    func displayLoadScene(viewModel: Splash.LoadScene.ViewModel)
}

protocol SplashViewControllerOutput
{
    func loadScene(request: Splash.LoadScene.Request)
}

class SplashViewController: UIViewController
{
    var output: SplashViewControllerOutput!
    var router: SplashRouter!

    // MARK: - Object lifecycle

    override func awakeFromNib()
    {
        super.awakeFromNib()
        SplashConfigurator.configure(viewController: self)
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        loadScene()
    }
}

// MARK: - Events
extension SplashViewController
{
    func loadScene()
    {
        let request = Splash.LoadScene.Request()
        output.loadScene(request: request)
    }
}

// MARK: - Display
extension SplashViewController: SplashViewControllerInput
{
    func displayLoadScene(viewModel _: Splash.LoadScene.ViewModel)
    {
    }
}