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
    func loadScene(request: Play.LoadGame.Request)
    func submitMove(request: Play.SubmitMove.Request)
}

class PlayInteractor: PlayBusinessLogic, PlayDataStore {
    var presenter: PlayPresentationLogic?
    var playWorker: PlayWorker

    required init() {
        let apiStore = OGSApiStore(sessionController: OGSSessionController.sharedInstance)
        playWorker = PlayWorker(gameStore: GameAPI(apiStore: apiStore), imageApi: AvatarApi(apiStore: apiStore))
    }

    func loadScene(request _: Play.LoadGame.Request) {
        let promise = playWorker.loadGame(id: 3673).get { _ in
            self.playWorker.delegate = self
        }

        presenter?.presentLoadScene(response: promise)
    }

    func submitMove(request: Play.SubmitMove.Request) {
        playWorker.submitMove(request.move)
    }
}

// MARK: - PlayWorker Delegate

extension PlayInteractor: PlayWorkerDelegate {
    func gameUpdated(state: GoState) {
        let response = Play.UpdateGame.Response(state: state)
        presenter?.presentUpdateGame(response: response)
    }

    func gameClockUpdated(_ response: Play.UpdateClock.Response) {
        presenter?.presentUpdateClock(response: response)
    }
}
