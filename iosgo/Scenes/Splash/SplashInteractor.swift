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

protocol SplashInteractorInput {
    func loadScene(request: Splash.LoadScene.Request)
}

protocol SplashInteractorOutput {
    func presentLoadScene(response: Splash.LoadScene.Response)
}

class SplashInteractor: SplashInteractorInput {
    var output: SplashInteractorOutput!

    private var readyList = [false, false]
    private var response = Splash.LoadScene.Response(loggedIn: false)

    func loadScene(request _: Splash.LoadScene.Request) {
        let configurator = OGSAppConfigurator(session: OGSSession(configuration: OGSBetaConfiguration()))
        configurator.configureApp { success in
            if success {
                self.readyList[0] = true
                self.finishScene()
            }
        }

        OGSSessionController.sharedInstance.initialize { result in
            switch result {
            case .success:
                self.response.loggedIn = true
                break
            case .error:
                self.response.loggedIn = false
                break
            }

            self.readyList[1] = true
            self.finishScene()
        }
    }
}

// MARK: - Output
private extension SplashInteractor {
    func finishScene() {
        guard allReady() else {
            return
        }

        output.presentLoadScene(response: response)
    }

    func allReady() -> Bool {
        for ready in readyList {
            guard ready else {
                return false
            }
        }
        return true
    }
}
