//
// Created by Jeffrey Wu on 2017-05-11.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import PromiseKit

class OGSSessionController {

    static let sharedInstance = OGSSessionController(session: OGSSession(configuration: OGSMockConfiguration()))

    let queue = DispatchQueue(label: "com.okAystudios.iosgo.OGSSessionController")

    var current: OGSSession
    var apiStore: OGSApiStore!

    required init(session: OGSSession) {
        current = session
        postInit()
    }

    fileprivate func postInit() {
        apiStore = OGSApiStore(sessionController: self)
    }

    func initialize() -> Promise<Empty> {
        return getCurrentUser().recover { error -> Promise<OGSUser> in
            switch error {
            case ApiError.unauthorized:
                return self.refreshTokens().then { _ in
                    self.getCurrentUser()
                }
            default:
                throw error
            }
        }.then { _ in
            self.getConfig()
        }.map { _ in Empty()
        }
    }

    func setTokens(accessToken: String, refreshToken: String) {
        queue.sync {
            current.accessToken = accessToken
            current.refreshToken = refreshToken
        }
    }

    fileprivate func refreshTokens() -> Promise<Empty> {
        let oauthStore = OauthApi(apiStore: apiStore)

        return oauthStore.refreshTokens().map { _ -> Empty in Empty() }
    }

    private func getCurrentUser() -> Promise<OGSUser> {
        let meApi = MeApi(apiStore: apiStore)

        return meApi.getUser()
    }

    fileprivate func getConfig() -> Promise<Config> {
        let configApi = ConfigAPI(apiStore: apiStore)

        return configApi.config().get(on: queue) { config in
            self.current.userConfiguration = config
        }
    }
}

fileprivate class OGSMockConfiguration: OGSConfigurationProtocol {
    var domainName: String = ""
    var clientID: String = ""
    var clientSecret: String = ""
    var socketAddress: String = ""
}
