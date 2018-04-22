//
// Created by Cheese Onhead on 5/27/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox
import PromiseKit

class MeApi {

    let url = "api/v1/me/"
    var apiStore: OGSApiStore

    required init(apiStore: OGSApiStore) {
        self.apiStore = apiStore
    }

    func getUser() -> Promise<OGSUser> {
        return apiStore.request(toUrl: url, method: .GET, parameters: [:], resultType: OGSUser.self)
    }
}
