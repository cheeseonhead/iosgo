//
//  GameSocket.swift
//  iosgo
//
//  Created by Cheese Onhead on 7/2/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox

protocol GameSocketDelegate: class {
    func handleMove(_ move: BoardPoint)
    func updateGameData(_ gameData: GameData)
}

class GameSocket {
    private typealias Models = GameSocketModels

    var socket: SocketManager
    var gameId: Int
    var playerId: Int
    weak var delegate: GameSocketDelegate?

    required init(socketManager: SocketManager, gameId: Int, playerId: Int) {
        socket = socketManager
        self.gameId = gameId
        self.playerId = playerId
    }

    func connect() {
        socket.on(GameSocketEventCreator(gameId: gameId, eventType: .receiveMove)) { [weak self] data in
            guard let dict: JSON = data[0] as? JSON,
                let moveModel = try? JSONDecoder().decode(Models.ReceivedMove.self, from: dict) else {
                return
            }
            self?.handleMove(model: moveModel)
        }

        socket.on(GameSocketEventCreator(gameId: gameId, eventType: .gamedata)) { [weak self] data in
            guard let strongSelf = self,
                let dictionary = data[0] as? UnboxableDictionary,
                let gameData: GameData = try? unbox(dictionary: dictionary) else {
                return
            }

            strongSelf.handleGameData(gameData: gameData)
        }

        socket.on(GameSocketEventCreator(gameId: gameId, eventType: .clock), classType: Models.ReceiveClock.self) { [weak self] model in
            self?.handleClock(model: model)
        }

        socket.onConnect { [weak self] in
            guard let strongSelf = self else { return }

            let connectData = Models.Connect(chat: true, gameId: strongSelf.gameId, playerId: strongSelf.playerId)
            strongSelf.socket.emit(GameSocketEventCreator(gameId: strongSelf.gameId, eventType: .connect), with: connectData)
        }
    }

    func submitMove(_ move: String) {
        let submitMoveData = Models.SubmitMove(gameId: gameId, move: move, playerId: playerId)

        socket.emit(GameSocketEventCreator(gameId: gameId, eventType: .submitMove), with: submitMoveData)
    }
}

// MARK: - Handlers

private extension GameSocket {
    private func handleMove(model: Models.ReceivedMove) {
        delegate?.handleMove(model.move)
    }

    private func handleGameData(gameData: GameData) {
        delegate?.updateGameData(gameData)
    }

    private func handleClock(model: Models.ReceiveClock) {
        print(model)
    }
}
