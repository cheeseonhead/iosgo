//
//  OGSLoginInteractor.swift
//  iosgo
//
//  Created by Jeffrey Wu on 2017-02-15.
//  Copyright (c) 2017 Cheeseonhead. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol OGSLoginInteractorInput
{
    func login(request: OGSLogin.Login.Request)
    func fieldsChange(request: OGSLogin.FieldsChanged.Request)
}

protocol OGSLoginInteractorOutput
{
    func presentLogin(response: OGSLogin.Login.Response)
    func presentFieldsChange(response: OGSLogin.FieldsChanged.Response)
}

class OGSLoginInteractor: OGSLoginInteractorInput
{
    var output: OGSLoginInteractorOutput!
    var loginWorker: OGSLoginWorker = {
        let sessionController = OGSSessionController.sharedInstance
        let apiStore = OGSApiStore(sessionController: sessionController)
        return OGSLoginWorker(authStore: OGSOauthApiStore(apiStore: apiStore), meStore: OGSMeStore(apiStore: apiStore, sessionController: sessionController))
    }()

    // MARK: - Business logic

    func login(request: OGSLogin.Login.Request)
    {
        let response = createInitialResponse()
        output.presentLogin(response: response)

        loginWorker.loginWith(username: request.username, password: request.password)
        { workerResponse in
            self.output.presentLogin(response: workerResponse)
        }
    }

    func fieldsChange(request: OGSLogin.FieldsChanged.Request)
    {
        let response = OGSLogin.FieldsChanged.Response(textFieldTexts: request.textFieldTexts)
        output.presentFieldsChange(response: response)
    }
}

fileprivate extension OGSLoginInteractor
{
    func createInitialResponse() -> OGSLogin.Login.Response
    {
        let response = OGSLogin.Login.Response(loadingStatus: .loading)
        return response
    }
}

extension OGSOauthApiStore: OGSAuthenticationStoreProtocol {}