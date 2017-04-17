//
// Created by Jeffrey Wu on 2017-02-17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class OGSOauthApiStore
{
    fileprivate var apiManager: OGSApiManager!

    required init(apiManager: OGSApiManager)
    {
        self.apiManager = apiManager
    }

    func getToken(with username: String, password: String, completion: @escaping (OGSLoginInfo) -> Void)
    {
        let url = "oauth2/token/"

        let params = [
            "client_id": OGSApiManager.sharedInstance.clientId!,
            "client_secret": OGSApiManager.sharedInstance.clientSecret!,
            "grant_type": "password",
            "username": username,
            "password": password,
        ]

        apiManager.request(toUrl: url, method: .POST, parameters: params)
        { statusCode, payload, _ in

            var loginInfo = OGSLoginInfo(result: .error(type: .unknownError))

            switch statusCode {
            case .ok:
                guard let correctPayload = payload,
                    let tokenInfo = self.createTokenInfo(from: correctPayload) else
                {
                    loginInfo.result = .error(type: .unknownError)
                    completion(loginInfo)
                    return
                }
                loginInfo.result = .success(info: tokenInfo)
            case .unauthorized:
                loginInfo.result = .error(type: .invalidLoginInfo)
                break
            case .clientError:
                loginInfo.result = .error(type: .clientError)
                break
            default:
                loginInfo.result = .error(type: .unknownError)
            }

            completion(loginInfo)
        }
    }

    fileprivate func createTokenInfo(from payload: [String: Any]) -> OGSLoginInfo.TokenInfo?
    {
        guard let accessToken = payload["access_token"] as? String,
            let tokenType = payload["token_type"] as? String,
            let expiresIn = payload["expires_in"] as? Int,
            let refreshToken = payload["refresh_token"] as? String,
            let scope = payload["scope"] as? String else
        {
            return nil
        }

        return OGSLoginInfo.TokenInfo(accessToken: accessToken, tokenType: tokenType, expiresIn: expiresIn, refreshToken: refreshToken, scope: scope)
    }
}
