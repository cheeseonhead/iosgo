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

    struct ReceivedMove: Decodable {
        var gameId: Int
        var move: BoardPoint
        var moveNumber: Int

        enum CodingKeys: String, CodingKey {
            case gameId = "game_id"
            case move
            case moveNumber = "move_number"
        }

        public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            gameId = try values.decode(Int.self, forKey: .gameId)

            let genericMove: [Int] = try values.decode([Int].self, forKey: .move)
            move = BoardPoint(row: genericMove[1], column: genericMove[0])
            moveNumber = try values.decode(Int.self, forKey: .moveNumber)
        }
    }

    struct SubmitMove: Encodable & SocketData {
        let gameId: Int
        let move: BoardPoint
        let playerId: Int

        func socketRepresentation() -> SocketData {
            return [
                "game_id": gameId,
                "move": move.toLetters(),
                "player_id": playerId,
            ]
        }
    }
}
