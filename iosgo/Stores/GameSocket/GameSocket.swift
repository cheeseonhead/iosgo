//
//  GameSocket.swift
//  iosgo
//
//  Created by Cheese Onhead on 7/2/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class GameSocket {

    private typealias Models = GameSocketModels

    var socket: SocketManager
    var gameId: Int
    var playerId: Int

    required init(socketManager: SocketManager, gameId: Int, playerId: Int) {
        self.socket = socketManager
        self.gameId = gameId
    }

    func connect() {
        socket.on(GameSocketEventCreator(gameId: gameId, eventType: .move)) { data in
            print(data[1])
        }

        let connectData = Models.Connect(chat: true, gameId: gameId, playerId: playerId)
        socket.emit(event: GameSocketEventCreator(gameId: gameId, eventType: .connect), with: connectData)
    }
}
