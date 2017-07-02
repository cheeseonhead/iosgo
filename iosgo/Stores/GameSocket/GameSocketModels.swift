//
//  GameSocketModels.swift
//  iosgo
//
//  Created by Cheese Onhead on 7/2/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import SocketIO

enum GameSocketModels {

    struct Connect: SocketData {

        var chat: Bool
        var gameId: Int
        var playerId: Int

        func socketRepresentation() -> SocketData {
            return ["chat": chat, "game_id": gameId, "player_id": playerId]
        }
    }
}
