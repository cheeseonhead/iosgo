//
// Created by Cheese Onhead on 3/5/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import SocketIO

class OGSSocketManager {
    static var sharedInstance = OGSSocketManager()

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

extension OGSSocketManager {
    func emit(event: SocketEvents, with data: SocketData) {
        if !isConnected {
            once(event: .connect) { _ in
                self.socket.emit(event.rawValue, data)
            }
        } else {
            socket.emit(event.rawValue, data)
        }
    }

    func on(event: SocketEvents, closure: @escaping NormalCallback) {

        socket.on(event.rawValue) { data, _ in
            closure(data)
        }
    }

    func once(event: SocketEvents, closure: @escaping NormalCallback) {
        socket.once(event.rawValue) { data, _ in
            closure(data)
        }
    }
}

// MARK: - Handlers
extension OGSSocketManager {
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
