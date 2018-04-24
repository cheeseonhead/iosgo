//
//  PlayPresenter.swift
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
import PromiseKit

protocol PlayPresentationLogic {
    func presentLoadScene(response: Promise<Play.LoadGame.Response>)
    func presentUpdateGame(response: Play.UpdateGame.Response)
    func presentUpdateClock(response: Play.UpdateClock.Response)
}

class PlayPresenter: PlayPresentationLogic {
    weak var viewController: PlayDisplayLogic?

    private var renderer = GameRenderer()

    func presentLoadScene(response: Promise<Play.LoadGame.Response>) {
        response.done(on: DispatchQueue.main) { response in
            let state = self.renderer.getState(from: response.state)

            let black = self.user(from: response.black)
            let white = self.user(from: response.white)

            let model = Play.LoadGame.ViewModel(state: state, black: black, white: white)
            self.viewController?.displayLoadScene(viewModel: model)
        }.catch { error in
            self.viewController?.errorAlert(error)
        }
    }

    func presentUpdateGame(response: Play.UpdateGame.Response) {
        let state = renderer.getState(from: response.state)

        let model = Play.UpdateGame.ViewModel(state: state)
        viewController?.displayUpdateGame(viewModel: model)
    }

    func presentUpdateClock(response: Play.UpdateClock.Response) {
        let viewModel = clockVM(response)

        viewController?.displayUpdateClock(viewModel: viewModel)
    }
}

private extension PlayPresenter {
    func clockVM(_ response: Play.UpdateClock.Response) -> Play.UpdateClock.ViewModel {
        let formatter = TimeTypeFormatter()

        let blackStr = formatter.string(from: response.blackClock)
        let whiteStr = formatter.string(from: response.whiteClock)

        let vm = Play.UpdateClock.ViewModel(blackTimeStr: blackStr, whiteTimeStr: whiteStr)
        return vm
    }

    func user(from player: Play.LoadGame.Response.User) -> PlayerInfoViewModel.User {
        return PlayerInfoViewModel.User(username: player.username, profile: player.icon)
    }
}
