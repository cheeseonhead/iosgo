//
// Created by Cheese Onhead on 5/27/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox
import PromiseKit

class OGSMeStore {
    struct Response {
        var result: Result

        enum Result {
            case success(user: OGSUser)
            case error(type: ApiError)
        }
    }

    let url = "api/v1/me/"
    var apiStore: OGSApiStore
    var sessionController: OGSSessionController

    required init(apiStore: OGSApiStore, sessionController: OGSSessionController) {
        self.apiStore = apiStore
        self.sessionController = sessionController
    }

    func getUser(completion _: @escaping (Response) -> Void) -> Promise<OGSUser> {
        return apiStore.request(toUrl: url, method: .GET, parameters: [:], resultType: OGSUser.self)
    }
}
