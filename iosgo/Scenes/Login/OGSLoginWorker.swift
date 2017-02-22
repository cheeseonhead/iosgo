//
// Created by Cheese Onhead on 2/17/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class OGSLoginWorker
{
    enum LoginErrorType
    {
        case usernameNotFound
        case passwordIncorrect
    }

    struct LoginResult
    {
        var success: Bool
        var loginError: LoginErrorType
    }

    var authStore: OGSOauthStoreProtocol

    init(authStore: OGSOauthStoreProtocol)
    {
        self.authStore = authStore
    }

    func loginWith(username: String, password: String, completion _: @escaping (_: OGSLogin.Login.Response) -> Void)
    {
        authStore.getToken(with: username, password: password)
        { tokenResult in
            switch tokenResult {
            case .success(let tokenInfo):
                break
            case .error(let errorType):
                break
            }
        }
    }
}
