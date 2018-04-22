//
//  GameSocket.swift
//  iosgo
//
//  Created by Cheese Onhead on 7/2/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox
import PromiseKit

protocol GameSocketDelegate: class {
    func handleMove(_ move: BoardPoint)
    func handleClock(_ clock: Clock)
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
        socket.on(GameSocketEventCreator(gameId: gameId, eventType: .receiveMove), resultType: Models.ReceivedMove.self) { promise in
            promise.done { [weak self] receivedMove in
                self?.handleMove(model: receivedMove)

            }.catch { print($0) }
        }

        socket.on(GameSocketEventCreator(gameId: gameId, eventType: .gamedata), resultType: GameData.self) { promise in
            promise.done { [weak self] gameData in
                self?.handleGameData(gameData: gameData)
            }.catch {
                print($0)
            }
        }

        socket.on(GameSocketEventCreator(gameId: gameId, eventType: .clock), resultType: Models.ReceivedClock.self) { promise in
            promise.done { [weak self] model in
                self?.handleClock(model: model)
            }.catch {
                print($0)
            }
        }

        socket.onceConnected().done { [weak self] _ in

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

    private func handleClock(model: Models.ReceivedClock) {
        delegate?.handleClock(model)
    }
}
