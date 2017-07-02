//
//  PlayInteractor.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/25/17.
//  Copyright (c) 2017 Cheeseonhead. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol PlayBusinessLogic {
    func loadScene(request: Play.LoadScene.Request)
}

class PlayInteractor: PlayBusinessLogic, PlayDataStore {

    var presenter: PlayPresentationLogic?
    var playWorker = PlayWorker(gameStore: GameStore(apiStore: OGSApiStore(sessionController: OGSSessionController.sharedInstance)))

    func loadScene(request _: Play.LoadScene.Request) {

        playWorker.loadGame(id: 2860) { result in
            switch result {
            case .success(let state):
                let response = Play.LoadScene.Response(state: state)
                self.presenter?.presentLoadScene(response: response)
            case .error(let message):
                print(message)
            }
        }
    }
}
