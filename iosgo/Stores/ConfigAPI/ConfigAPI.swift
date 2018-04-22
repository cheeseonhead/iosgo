//
//  ConfigAPI.swift
//  iosgo
//
//  Created by Jeffrey Wu on 2018-04-12.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation
import PromiseKit

class ConfigAPI {
    enum Result<T> {
        case success(T)
        case error(ApiError)
    }

    let apiStore: OGSApiStore

    required init(apiStore: OGSApiStore) {
        self.apiStore = apiStore
    }

    func config() -> Promise<Config> {
        let url = "api/v1/ui/config"

        return apiStore.request(toUrl: url, method: .GET, parameters: [:], resultType: Config.self)
    }
}
