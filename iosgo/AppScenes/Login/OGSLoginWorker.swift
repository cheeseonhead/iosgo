//
// Created by Cheese Onhead on 2/17/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import PromiseKit

class OGSLoginWorker {

    var authStore: OauthApi
    var meStore: MeApi

    init(authStore: OauthApi, meStore: MeApi) {
        self.authStore = authStore
        self.meStore = meStore
    }

    func loginWith(username: String, password: String) -> Promise<OGSLogin.Login.Response> {

        return authStore.getToken(with: username, password: password)
            .tap { print($0) }
            .map { _ in OGSLogin.Login.Response() }
    }
}
