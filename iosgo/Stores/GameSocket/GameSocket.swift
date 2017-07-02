//
//  GameSocket.swift
//  iosgo
//
//  Created by Cheese Onhead on 7/2/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox

protocol GameSocketDelegate {
    func move(_ move: BoardPoint)
}

class GameSocket {

    private typealias Models = GameSocketModels

    var socket: SocketManager
    var gameId: Int
    var playerId: Int

    required init(socketManager: SocketManager, gameId: Int, playerId: Int) {
        self.socket = socketManager
        self.gameId = gameId
        self.playerId = playerId
    }

    func connect() {
        socket.on(GameSocketEventCreator(gameId: gameId, eventType: .move)) { data in
            guard let dictionary = data[0] as? UnboxableDictionary,
                let moveModel: Models.Move = try? unbox(dictionary: dictionary) else {
                return
            }
            self.handleMove(model: moveModel)
        }

        let connectData = Models.Connect(chat: true, gameId: gameId, playerId: playerId)
        socket.emit(GameSocketEventCreator(gameId: gameId, eventType: .connect), with: connectData)
    }
}

// MARK: - Handlers
private extension GameSocket {

    private func handleMove(model: Models.Move) {
        print(model)
    }
}
