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

    struct Response {
        var result: Result
    }

    enum Result {
        case success(game: Game)
        case error(type: ApiError)
    }

    private var apiStore: OGSApiStore

    required init(apiStore: OGSApiStore) {
        self.apiStore = apiStore
    }

    func game(id: Int) -> Promise<Game> {
        let url = "api/v1/games/\(String(id))"

        return apiStore.request(toUrl: url, method: .GET, parameters: [:], resultType: Game.self)
    }
}
