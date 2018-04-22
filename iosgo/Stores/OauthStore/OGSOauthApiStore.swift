//
// Created by Jeffrey Wu on 2017-02-17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox
import PromiseKit

class OGSOauthApiStore {
    let URL = "oauth2/token/"

    fileprivate var apiStore: OGSApiStore

    required init(apiStore: OGSApiStore) {
        self.apiStore = apiStore
    }

    func getToken(with username: String, password: String, completion _: @escaping (OGSLoginInfo) -> Void) -> Promise<OGSLoginInfo> {

        let params: [String: String] = [
            "client_id": apiStore.clientID,
            "client_secret": apiStore.clientSecret,
            "grant_type": "password",
            "username": username,
            "password": password,
        ]

        return sendRequest(toUrl: URL, method: .POST, parameters: params)
    }

    func refreshTokens(completion _: @escaping (OGSLoginInfo) -> Void) -> Promise<OGSLoginInfo> {

        return firstly { () -> Promise<OGSLoginInfo> in
            guard let refreshToken = apiStore.refreshToken else {
                throw ApiError.unauthorized
            }

            let params: [String: String] = [
                "client_id": apiStore.clientID,
                "client_secret": apiStore.clientSecret,
                "grant_type": "refresh_token",
                "refresh_token": refreshToken,
            ]

            return sendRequest(toUrl: URL, method: .POST, parameters: params)
        }
    }

    fileprivate func sendRequest(toUrl url: String, method: HTTPMethod, parameters: [String: String]) -> Promise<OGSLoginInfo> {
        return apiStore.request(toUrl: url, method: method, parameters: parameters, resultType: OGSLoginInfo.self)
    }

    fileprivate func updateTokens(with tokenInfo: OGSLoginInfo) {
        apiStore.accessToken = tokenInfo.accessToken
        apiStore.refreshToken = tokenInfo.refreshToken
    }
}
