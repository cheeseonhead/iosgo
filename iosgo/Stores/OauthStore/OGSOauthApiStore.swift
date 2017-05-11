//
// Created by Jeffrey Wu on 2017-02-17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox

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
            "client_id": apiManager.clientId!,
            "client_secret": apiManager.clientSecret!,
            "grant_type": "password",
            "username": username,
            "password": password,
        ]

        apiManager.request(toUrl: url, method: .POST, parameters: params)
        { statusCode, payload, _ in

            var loginInfo = OGSLoginInfo(result: .error(type: .unknownError))

            switch statusCode {
            case .ok:
                if let tokenInfo = try? self.createTokenInfo(from: payload!)
                {
                    loginInfo.result = .success(info: tokenInfo)
                }
                else
                {
                    loginInfo.result = .error(type: .unknownError)
                }
                break
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

    fileprivate func createTokenInfo(from payload: [String: Any]) throws -> OGSLoginInfo.TokenInfo
    {
        let tokenInfo: OGSLoginInfo.TokenInfo = try unbox(dictionary: payload)
        return tokenInfo
    }
}
