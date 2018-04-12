//
//  SocketManagerModels.swift
//  iosgo
//
//  Created by Jeffrey Wu on 2018-04-12.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation
import SocketIO

enum SocketManagerModels {
    struct Authenticate: SocketData {
        var auth: String
        var playerId: Int
        var username: String

        func socketRepresentation() -> SocketData {
            return ["auth": auth, "player_id": playerId, "username": username]
        }
    }
}
