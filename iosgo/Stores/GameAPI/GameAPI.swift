//
//  GameStore.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/24/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox
import PromiseKit

class GameAPI {

    private var apiStore: OGSApiStore

    required init(apiStore: OGSApiStore) {
        self.apiStore = apiStore
    }

    func game(id: Int) -> Promise<Game> {
        let url = "api/v1/games/\(String(id))"

        return apiStore.request(toUrl: url, method: .GET, parameters: [:], resultType: Game.self)
    }
}
