//
// Created by Jeffrey Wu on 2017-05-11.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import PromiseKit

class OGSSessionController {

    static let sharedInstance = OGSSessionController(session: OGSSession(configuration: OGSMockConfiguration()))

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
        return getConfig().recover { error -> Promise<Config> in
            switch error {
            case ApiError.unauthorized:
                return self.refreshTokens().then { _ in
                    self.getConfig()
                }
            default:
                throw error
            }
        }.map { _ in Empty()
        }
    }

    fileprivate func refreshTokens() -> Promise<Empty> {
        let oauthStore = OGSOauthApiStore(apiStore: apiStore)

        return oauthStore.refreshTokens().map { _ -> Empty in Empty() }
    }

    fileprivate func getConfig() -> Promise<Config> {
        let configApi = ConfigAPI(apiStore: apiStore)

        return configApi.config().get { config in
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
