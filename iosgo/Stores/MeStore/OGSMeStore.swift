//
// Created by Cheese Onhead on 5/27/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox

class OGSMeStore {
    struct Response {
        var result: Result

        enum Result {
            case success(user: OGSUser)
            case error(type: ApiErrorType)
        }
    }

    let url = "api/v1/me/"
    var apiStore: OGSApiStore
    var sessionController: OGSSessionController

    required init(apiStore: OGSApiStore, sessionController: OGSSessionController) {
        self.apiStore = apiStore
        self.sessionController = sessionController
    }

    func getUser(completion: @escaping (Response) -> Void) {
        apiStore.request(toUrl: url, method: .GET, parameters: [:]) { statusCode, payload, _ in
            var response = Response(result: .error(type: ApiErrorType.init(statusCode: statusCode)))

            switch statusCode {
            case .ok:
                if let user = try? self.createUser(from: payload!) {
                    response.result = .success(user: user)
                }
            case .unauthorized:
                response.result = .error(type: .unauthorized)
            default:
                break
            }

            completion(response)
        }
    }
}

fileprivate extension OGSMeStore {
    func createUser(from payload: [String: Any]) throws -> OGSUser {
        let user: OGSUser = try unbox(dictionary: payload)
        return user
    }
}
