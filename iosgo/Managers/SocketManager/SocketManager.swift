//
// Created by Cheese Onhead on 3/5/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import SocketIO

class SocketManager {
    static var sharedInstance = SocketManager()

    var socketAddress: String!
    var isConnected = false

    fileprivate var socket: SocketIOClient!

    func connect(completion: @escaping (Bool) -> Void) {
        socket = SocketIOClient(socketURL: URL(string: socketAddress)!, config: [.log(false), .forceWebsockets(true)])

        once(event: .connect) { _ in
            completion(true)
        }

        on(event: .connect) { _ in
            self.websocketDidConnect(socket: self.socket)
        }

        on(event: .disconnect) { _ in
            self.websocketDidDisconnect(socket: self.socket)
        }

        socket.connect()
    }
}

extension SocketManager {
    func emit(event: SocketEvents, with data: SocketData) {
        emit(rawEvent: event.rawValue, with: data)
    }

    func emit(_ socketEventCreator: SocketEventCreating, with data: SocketData) {
        emit(rawEvent: socketEventCreator.eventName, with: data)
    }

    func on(event: SocketEvents, closure: @escaping NormalCallback) {

        socket.on(event.rawValue) { data, _ in
            closure(data)
        }
    }

    func on(_ socketEventCreator: SocketEventCreating, closure: @escaping NormalCallback) {

        socket.on(socketEventCreator.eventName) { data, _ in
            closure(data)
        }
    }

    func once(event: SocketEvents, closure: @escaping NormalCallback) {
        socket.once(event.rawValue) { data, _ in
            closure(data)
        }
    }
}

// MARK: - Private
private extension SocketManager {

    func emit(rawEvent: SocketEvent, with data: SocketData) {
        if !isConnected {
            once(event: .connect) { _ in
                self.socket.emit(rawEvent, data)
            }
        } else {
            socket.emit(rawEvent, data)
        }
    }
}

// MARK: - Handlers
extension SocketManager {
    func websocketDidConnect(socket _: SocketIOClient) {
        isConnected = true
    }

    func websocketDidDisconnect(socket _: SocketIOClient) {
        isConnected = false
    }

    func websocketDidReceiveMessage(socket _: SocketIOClient, text _: String) {
    }

    func websocketDidReceiveData(socket _: SocketIOClient, data _: Data) {
    }
}