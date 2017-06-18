//
//  PlayViewController.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/18/17.
//  Copyright (c) 2017 Cheeseonhead. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol PlayViewControllerViewControllerInput {
}

protocol PlayViewControllerViewControllerOutput {
}

class PlayViewControllerViewController: UIViewController, PlayViewControllerViewControllerInput {
    var output: PlayViewControllerViewControllerOutput!
    var router: PlayViewControllerRouter!

    // MARK: - Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        PlayViewControllerConfigurator.configure(viewController: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "BoardScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit

                // Present the scene
                view.presentScene(scene)
            }

            view.ignoresSiblingOrder = true

            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
}
