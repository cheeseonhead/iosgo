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

    func loginWith(username: String, password: String, completion: @escaping (_: OGSLogin.Login.Response) -> Void)
    {
        authStore.getToken(with: username, password: password)
        { tokenResult in
            var response: OGSLogin.Login.Response!

            switch tokenResult {
            case .success(let tokenInfo):
                self.broadcastTokensUpdated(with: tokenInfo)
                response = self.createLoginSuccessResponse()
                break
            case .error(let errorType):
                response = self.createLoginErrorResponse(errorType: errorType)
                break
            }

            completion(response)
        }
    }
}

fileprivate extension OGSLoginWorker
{
    func broadcastTokensUpdated(with tokenInfo: OGSOauthStore.TokenInfo)
    {
        OGSNotificationCenter.sharedInstance.post(name: .accessTokenUpdated, object: tokenInfo.accessToken)
        OGSNotificationCenter.sharedInstance.post(name: .refreshTokenUpdated, object: tokenInfo.refreshToken)
    }

    func createLoginSuccessResponse() -> OGSLogin.Login.Response
    {
        let response = OGSLogin.Login.Response(loadingStatus: .success)

        return response
    }

    func createLoginErrorResponse(errorType: OGSOauthStore.ErrorType) -> OGSLogin.Login.Response
    {
        var responseError: OGSLogin.Login.Response.ErrorType!

        switch errorType {
        case .invalidLoginInfo:
            responseError = .invalidLoginInfo
            break
        case .clientError:
            responseError = .networkError
            break
        case .unknownError:
            responseError = .unknownError
            break
        }

        let response = OGSLogin.Login.Response(loadingStatus: .error(responseError))
        return response
    }
}
