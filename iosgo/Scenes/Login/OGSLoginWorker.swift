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
    var meStore: OGSMeStore

    init(authStore: OGSAuthenticationStoreProtocol, meStore: OGSMeStore)
    {
        self.authStore = authStore
        self.meStore = meStore
    }

    func loginWith(username: String, password: String, completion: @escaping (_: OGSLogin.Login.Response) -> Void)
    {
        authStore.getToken(with: username, password: password)
        { loginInfo in
            var response: OGSLogin.Login.Response!

            switch loginInfo.result {
            case .success:
                self.meStore.getUser
                { workerResponse in
                    switch workerResponse.result {
                    case .success:
                        response = self.createLoginSuccessResponse()
                    case let .error(errorType):
                        response = self.createLoginErrorResponse(errorType: errorType)
                    }
                    completion(response)
                }
                break
            case let .error(errorType):
                response = self.createLoginErrorResponse(errorType: errorType)
                completion(response)
                break
            }
        }
    }
}

fileprivate extension OGSLoginWorker
{
    func createLoginSuccessResponse() -> OGSLogin.Login.Response
    {
        let response = OGSLogin.Login.Response(loadingStatus: .success)

        return response
    }

    func createLoginErrorResponse(errorType: ApiErrorType) -> OGSLogin.Login.Response
    {
        var responseError: OGSLogin.Login.Response.ErrorType!

        switch errorType {
        case .unauthorized:
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
