//
// Created by Jeffrey Wu on 2017-05-11.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class OGSSessionController
{
    enum Initialize
    {
        enum Result
        {
            case success
            case error(type: Error)

            enum Error
            {
                case networkError
                case accessTokenInvalid
                case refreshTokenInvalid
            }
        }
    }

    static let sharedInstance = OGSSessionController(session: OGSSession(configuration: OGSMockConfiguration()))

    var current: OGSSession
    var apiStore: OGSApiStore!

    required init(session: OGSSession)
    {
        self.current = session
        postInit()
    }

    fileprivate func postInit()
    {
        apiStore = OGSApiStore(sessionController: self)
    }

    func initialize(completion: @escaping (Initialize.Result) -> Void)
    {
        guard current.tokensExists else
        {
            completion(.error(type: .refreshTokenInvalid))
            return
        }

        getUser
        { result in
            switch result {
            case .success:
                completion(.success)
            case .error(let type):
                switch type {
                case .accessTokenInvalid:
                    self.refreshTokens(completion: completion)
                default:
                    completion(.error(type: type))
                }
            }
        }
    }

    fileprivate func refreshTokens(completion: @escaping (Initialize.Result) -> Void)
    {
        let oauthStore = OGSOauthApiStore(apiStore: apiStore)

        oauthStore.refreshTokens
        { loginInfo in
            switch loginInfo.result {
            case .success:
                self.getUser
                { result in
                    switch result {
                    case .success:
                        completion(.success)
                    case .error:
                        completion(.error(type: .networkError))
                    }
                }
            case .error(let type):
                switch type {
                case .unauthorized:
                    completion(.error(type: .refreshTokenInvalid))
                default:
                    completion(.error(type: .networkError))
                }
            }
        }
    }

    fileprivate func getUser(completion: @escaping (Initialize.Result) -> Void)
    {
        let meStore = OGSMeStore(apiStore: apiStore, sessionController: self)

        meStore.getUser
        { response in
            switch response.result {
            case .success(let user):
                self.current.user = user
                completion(.success)
            case .error(let type):
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

fileprivate class OGSMockConfiguration: OGSConfigurationProtocol
{
    var domainName: String = ""
    var clientID: String = ""
    var clientSecret: String = ""
    var socketAddress: String = ""
}
