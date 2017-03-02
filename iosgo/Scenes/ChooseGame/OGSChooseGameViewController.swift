//
//  OGSChooseGameViewController.swift
//  iosgo
//
//  Created by Jeffrey Wu on 2017-02-26.
//  Copyright (c) 2017 Cheeseonhead. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol OGSChooseGameViewControllerInput
{
}

protocol OGSChooseGameViewControllerOutput
{
    func listGames(request: OGSChooseGame.ListGames.Request)
}

class OGSChooseGameViewController: UIViewController, OGSChooseGameViewControllerInput
{
    var output: OGSChooseGameViewControllerOutput!
    var router: OGSChooseGameRouter!

    override func awakeFromNib()
    {
        super.awakeFromNib()
        OGSChooseGameConfigurator.sharedInstance.configure(viewController: self)
    }

    override func viewDidLoad()
    {
        let request = OGSChooseGame.ListGames.Request()

        output.listGames(request: request)
    }
}
