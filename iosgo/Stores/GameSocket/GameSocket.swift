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
        self.playerId = playerId
    }

    func connect() {
        socket.on(GameSocketEventCreator(gameId: gameId, eventType: .move)) { data in
            print(data)
        }

        let connectData = Models.Connect(chat: true, gameId: gameId, playerId: playerId)
        socket.emit(GameSocketEventCreator(gameId: gameId, eventType: .connect), with: connectData)
    }
}
