//
// Created by Cheese Onhead on 2/17/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class OGSLoginWorker
{
    enum LoginErrorType {
        case usernameNotFound
        case passwordIncorrect
    }

    struct LoginResult {
        var success: Bool
        var loginError: LoginErrorType
    }

    func loginWith(username: String, password: String, completion: @escaping (_: LoginResult) -> Void)
    {
        let success = username == "jeffwoo" && password == "123qweasdzxc"
        var loginError: LoginErrorType!
        if username != "jeffwoo" {
            loginError = .usernameNotFound
        }
        else {
            loginError = .passwordIncorrect
        }
        let result = LoginResult(success: success, loginError: loginError)

        let smallDelayAfter = DispatchTime.now() + DispatchTimeInterval.milliseconds(3000)
        DispatchQueue.main.asyncAfter(deadline: smallDelayAfter, execute: {
            completion(result)
        })
    }
}