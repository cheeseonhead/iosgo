//
// Created by Cheese Onhead on 2/17/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

protocol OGSAuthenticationStoreProtocol
{
    func getToken(with username: String, password: String, completion: @escaping (OGSLoginInfo) -> Void)
}

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

    var authStore: OGSAuthenticationStoreProtocol
    var notificationCenter: OGSNotificationCenter

    init(authStore: OGSAuthenticationStoreProtocol, notificationCenter: OGSNotificationCenter)
    {
        self.authStore = authStore
        self.notificationCenter = notificationCenter
    }

    func loginWith(username: String, password: String, completion: @escaping (_: OGSLogin.Login.Response) -> Void)
    {
        authStore.getToken(with: username, password: password)
        { loginInfo in
            var response: OGSLogin.Login.Response!

            switch loginInfo.result {
            case let .success(tokenInfo):
                self.broadcastTokensUpdated(with: tokenInfo)
                response = self.createLoginSuccessResponse()
                break
            case let .error(errorType):
                response = self.createLoginErrorResponse(errorType: errorType)
                break
            }

            completion(response)
        }
    }
}

fileprivate extension OGSLoginWorker
{
    func broadcastTokensUpdated(with tokenInfo: OGSLoginInfo.TokenInfo)
    {
        notificationCenter.post(name: .accessTokenUpdated, object: tokenInfo.accessToken)
        notificationCenter.post(name: .refreshTokenUpdated, object: tokenInfo.refreshToken)
    }

    func createLoginSuccessResponse() -> OGSLogin.Login.Response
    {
        let response = OGSLogin.Login.Response(loadingStatus: .success)

        return response
    }

    func createLoginErrorResponse(errorType: OGSLoginInfo.ErrorType) -> OGSLogin.Login.Response
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
