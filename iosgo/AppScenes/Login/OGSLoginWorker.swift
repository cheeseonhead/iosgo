//
// Created by Cheese Onhead on 2/17/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import PromiseKit

protocol OGSAuthenticationStoreProtocol {
    func getToken(with username: String, password: String) -> Promise<OGSLoginInfo>
}

class OGSLoginWorker {

    var authStore: OGSAuthenticationStoreProtocol
    var meStore: OGSMeStore

    init(authStore: OGSAuthenticationStoreProtocol, meStore: OGSMeStore) {
        self.authStore = authStore
        self.meStore = meStore
    }

    func loginWith(username: String, password: String) -> Promise<OGSLogin.Login.Response> {

        return authStore.getToken(with: username, password: password)
            .map { _ in OGSLogin.Login.Response() }
    }
}
