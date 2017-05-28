//
// Created by Cheese Onhead on 5/27/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class OGSMeStore
{
    struct Response
    {
        var result: Result

        enum Result
        {
            case success
            case error(type: ErrorType)
        }

        enum ErrorType
        {
            case unauthorized
            case clientError
            case unknownError
        }
    }

    let url = "api/v1/me/"
    var apiStore: OGSApiStore

    required init(apiStore: OGSApiStore)
    {
        self.apiStore = apiStore
    }

    func getUser(completion: @escaping (Response) -> Void)
    {
        apiStore.request(toUrl: url, method: .GET, parameters: [:])
        { statusCode, _, _ in
            var response = Response(result: .error(type: .unknownError))

            switch statusCode {
            case .ok:
                response.result = .success
            case .unauthorized:
                response.result = .error(type: .unauthorized)
            case .clientError:
                response.result = .error(type: .clientError)
            default:
                break
            }

            completion(response)
        }
    }
}
