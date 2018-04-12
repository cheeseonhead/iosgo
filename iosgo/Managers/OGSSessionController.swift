//
// Created by Jeffrey Wu on 2017-05-11.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class OGSSessionController {
    enum Initialize {
        enum Result {
            case success
            case error(type: Error)

            enum Error {
                case networkError
                case accessTokenInvalid
                case refreshTokenInvalid
            }
        }
    }

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

    func initialize(completion: @escaping (Initialize.Result) -> Void) {
        guard current.tokensExists else {
            completion(.error(type: .refreshTokenInvalid))
            return
        }

        getConfig { result in
            switch result {
            case .success:
                completion(.success)
            case let .error(type):
                switch type {
                case .accessTokenInvalid:
                    self.refreshTokens(completion: completion)
                default:
                    completion(.error(type: type))
                }
            }
        }
    }

    fileprivate func refreshTokens(completion: @escaping (Initialize.Result) -> Void) {
        let oauthStore = OGSOauthApiStore(apiStore: apiStore)

        oauthStore.refreshTokens { loginInfo in
            switch loginInfo.result {
            case .success:
                self.getConfig { result in
                    switch result {
                    case .success:
                        completion(.success)
                    case .error:
                        completion(.error(type: .networkError))
                    }
                }
            case let .error(type):
                switch type {
                case .unauthorized:
                    completion(.error(type: .refreshTokenInvalid))
                default:
                    completion(.error(type: .networkError))
                }
            }
        }
    }

    fileprivate func getConfig(completion: @escaping (Initialize.Result) -> Void) {
        let configApi = ConfigAPI(apiStore: apiStore)

        configApi.config { result in
            switch result {
            case let .success(config):
                self.current.userConfiguration = config
                completion(.success)
            case let .error(type):
                switch type {
                case .unauthorized:
                    completion(.error(type: .accessTokenInvalid))
                default:
                    completion(.error(type: .networkError))
                }
            }
        }
    }
}

fileprivate class OGSMockConfiguration: OGSConfigurationProtocol {
    var domainName: String = ""
    var clientID: String = ""
    var clientSecret: String = ""
    var socketAddress: String = ""
}
