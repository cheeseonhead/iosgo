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
                case refreshTokenInvalid
            }
        }
    }

    static let sharedInstance = OGSSessionController(session: OGSSession(configuration: OGSMockConfiguration()))

    var current: OGSSession

    required init(session: OGSSession)
    {
        self.current = session
    }

    func initialize(completion: @escaping (Initialize.Result) -> Void)
    {
        let apiStore = OGSApiStore(sessionController: self)
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
                    self.refreshTokens(completion: completion)
                default:
                    completion(.error(type: .networkError))
                }
            }
        }
    }

    func refreshTokens(completion _: @escaping (Initialize.Result) -> Void)
    {
    }
}

fileprivate class OGSMockConfiguration: OGSConfigurationProtocol
{
    var domainName: String = ""
    var clientID: String = ""
    var clientSecret: String = ""
    var socketAddress: String = ""
}
