//
// Created by Jeffrey Wu on 2017-02-17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox

class OGSOauthApiStore {
    let URL = "oauth2/token/"

    fileprivate var apiStore: OGSApiStore

    required init(apiStore: OGSApiStore) {
        self.apiStore = apiStore
    }

    func getToken(with username: String, password: String, completion: @escaping (OGSLoginInfo) -> Void) {
        let params: [String: String] = [
            "client_id": apiStore.clientID,
            "client_secret": apiStore.clientSecret,
            "grant_type": "password",
            "username": username,
            "password": password,
        ]

        sendRequest(toUrl: URL, method: .POST, parameters: params, completion: completion)
    }

    func refreshTokens(completion: @escaping (OGSLoginInfo) -> Void) {
        guard let refreshToken = apiStore.refreshToken else {
            let loginInfo = OGSLoginInfo(result: .error(type: .unauthorized))
            completion(loginInfo)
            return
        }

        let params: [String: String] = [
            "client_id": apiStore.clientID,
            "client_secret": apiStore.clientSecret,
            "grant_type": "refresh_token",
            "refresh_token": refreshToken,
        ]

        sendRequest(toUrl: URL, method: .POST, parameters: params, completion: completion)
    }

    fileprivate func sendRequest(toUrl url: String, method: HTTPMethod, parameters: [String: String], completion: @escaping (OGSLoginInfo) -> Void) {
        apiStore.request(toUrl: url, method: method, parameters: parameters) { statusCode, payload, _ in

            var loginInfo = OGSLoginInfo(result: .error(type: ApiError(statusCode: statusCode)))

            switch statusCode {
            case .ok:
                if let tokenInfo = try? self.createTokenInfo(from: payload!) {
                    self.updateTokens(with: tokenInfo)
                    loginInfo.result = .success
                }
            case .unauthorized:
                loginInfo.result = .error(type: .unauthorized)
            default: break
            }

            completion(loginInfo)
        }
    }

    fileprivate func createTokenInfo(from payload: [String: Any]) throws -> OGSLoginInfo.TokenInfo {
        let tokenInfo: OGSLoginInfo.TokenInfo = try unbox(dictionary: payload)
        return tokenInfo
    }

    fileprivate func updateTokens(with tokenInfo: OGSLoginInfo.TokenInfo) {
        apiStore.accessToken = tokenInfo.accessToken
        apiStore.refreshToken = tokenInfo.refreshToken
    }
}
