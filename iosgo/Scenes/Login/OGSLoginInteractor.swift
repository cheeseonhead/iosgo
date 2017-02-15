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
    func doSomething(request: OGSLogin.Login.Request)
}

protocol OGSLoginInteractorOutput
{
    func presentLogin(response: OGSLogin.Login.Response)
}

class OGSLoginInteractor: OGSLoginInteractorInput
{
    var output: OGSLoginInteractorOutput!

    // MARK: - Business logic

    func doSomething(request _: OGSLogin.Login.Request)
    {
        // NOTE: Create some Worker to do the work

        // NOTE: Pass the result to the Presenter

        let response = OGSLogin.Login.Response()
        output.presentLogin(response: response)
    }
}