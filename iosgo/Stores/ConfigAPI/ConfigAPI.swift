//
//  ConfigAPI.swift
//  iosgo
//
//  Created by Jeffrey Wu on 2018-04-12.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation

class ConfigAPI {
    enum Result<T> {
        case success(T)
        case error(ApiErrorType)
    }

    let apiStore: OGSApiStore

    required init(apiStore: OGSApiStore) {
        self.apiStore = apiStore
    }

    func config(completion: @escaping (Result<Config>) -> Void) {
        let url = "api/v1/ui/config"

        apiStore.request(toUrl: url, method: .GET, parameters: [:]) { code, payload, _ in

            var result = Result<Config>.error(ApiErrorType(statusCode: code))

            switch code {
            case .ok:
                if let payload = payload, let config = try? JSONDecoder().decode(Config.self, from: payload) {
                    result = .success(config)
                }
            case .unauthorized:
                result = .error(.unauthorized)
            default:
                break
            }

            completion(result)
        }
    }
}
