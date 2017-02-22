//
// Created by Jeffrey Wu on 2017-02-17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class OGSOauthApiStore
{
    func getToken(with username: String, password: String, completion: @escaping (OGSOauthStore.GetTokenResult) -> Void)
    {
        var url = "oauth2/token/"

        var params = [
            "client_id": OGSApiManager.sharedInstance.clientId!,
            "client_secret": OGSApiManager.sharedInstance.clientSecret!,
            "grant_type": "password",
            "username": username,
            "password": password,
        ]

        OGSApiManager.sharedInstance.request(toUrl: url, method: .POST, parameters: params)
        { statusCode, payload, _ in

            switch statusCode
            {
            case .ok:
                guard let correctPayload = payload as? [String: String],
                    let tokenInfo = self.createTokenInfo(from: correctPayload) else
                {
                    completion(.error(type: .unknownError))
                    return
                }
                completion(.success(info: tokenInfo))
            case .unauthorized:
                completion(.error(type: .invalidLoginInfo))
                break
            default:
                completion(.error(type: .unknownError))
            }
        }
    }

    fileprivate func createTokenInfo(from payload: [String: String]) -> OGSOauthStore.TokenInfo?
    {
        guard let accessToken = payload["access_token"],
            let tokenType = payload["token_type"],
            let expiresIn = payload["expires_in"],
            let refreshToken = payload["refresh_token"],
            let scope = payload["scope"] else
        {
            return nil
        }

        return OGSOauthStore.TokenInfo(accessToken: accessToken, tokenType: tokenType, expiresIn: expiresIn, refreshToken: refreshToken, scope: scope)
    }
}
