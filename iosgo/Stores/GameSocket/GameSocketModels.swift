//
//  GameSocketModels.swift
//  iosgo
//
//  Created by Cheese Onhead on 7/2/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import SocketIO
import Unbox

enum GameSocketModels {
    struct Connect: SocketData {
        var chat: Bool
        var gameId: Int
        var playerId: Int

        func socketRepresentation() -> SocketData {
            return ["chat": chat, "game_id": gameId, "player_id": playerId]
        }
    }

    struct ReceivedMove: Unboxable {
        var gameId: Int
        var move: BoardPoint
        var moveNumber: Int

        init(unboxer: Unboxer) throws {
            gameId = try unboxer.unbox(key: "game_id")
            let genericMove: [Int] = try unboxer.unbox(key: "move")
            move = BoardPoint(row: genericMove[1], column: genericMove[0])
            moveNumber = try unboxer.unbox(key: "move_number")
        }
    }
}
