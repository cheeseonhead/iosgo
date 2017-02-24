//
//  OGSLoginPresenter.swift
//  iosgo
//
//  Created by Jeffrey Wu on 2017-02-15.
//  Copyright (c) 2017 Cheeseonhead. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol OGSLoginPresenterInput
{
    func presentLogin(response: OGSLogin.Login.Response)
    func presentFieldsChange(response: OGSLogin.FieldsChanged.Response)
}

protocol OGSLoginPresenterOutput: class
{
    func displayLogin(viewModel: OGSLogin.Login.ViewModel)
    func displayFieldsChange(viewModel: OGSLogin.FieldsChanged.ViewModel)
}

class OGSLoginPresenter: OGSLoginPresenterInput
{
    weak var output: OGSLoginPresenterOutput!

    func presentLogin(response: OGSLogin.Login.Response)
    {
        let readyToNavigate = readyToNavigateFrom(response: response)
        let userInputState = userInputStateFrom(response: response)
        let errorLabelState = errorLabelStateFrom(response: response)

        let viewModel = OGSLogin.Login.ViewModel(readyToNavigate: readyToNavigate, userInputState: userInputState, errorLabelState: errorLabelState)
        OGSDispatcher.asyncMain {
            self.output.displayLogin(viewModel: viewModel)
        }
    }

    func presentFieldsChange(response: OGSLogin.FieldsChanged.Response)
    {
        var viewModel = OGSLogin.FieldsChanged.ViewModel(buttonEnabled: true)

        for text in response.textFieldTexts
        {
            if text.characters.count == 0
            {
                viewModel.buttonEnabled = false
            }
        }

        OGSDispatcher.asyncMain {
            self.output.displayFieldsChange(viewModel: viewModel)
        }
    }
}

fileprivate extension OGSLoginPresenter
{
    func readyToNavigateFrom(response: OGSLogin.Login.Response) -> Bool
    {
        switch response.loadingStatus {
            case .success:
                return true
            case .error, .loading:
                return false
        }
    }

    func userInputStateFrom(response: OGSLogin.Login.Response) -> OGSLogin.Login.ViewModel.UserInputState
    {
        switch response.loadingStatus {
            case .loading:
                return .pending
            case .error, .success:
                return .ready
        }
    }

    func errorLabelStateFrom(response: OGSLogin.Login.Response) -> OGSLogin.Login.ViewModel.ErrorLabelState
    {
        switch response.loadingStatus {
            case .success, .loading:
                return .hidden
            case .error(let type):
                let errorText = type.rawValue
                return .showing(message: errorText)
        }
    }
}