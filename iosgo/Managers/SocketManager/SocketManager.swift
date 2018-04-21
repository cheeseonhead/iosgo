//
// Created by Cheese Onhead on 3/5/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import SocketIO

class SocketManager {
    static var sharedInstance = SocketManager()

    var sessionController: OGSSessionController?
    var isConnected = false

    private var manager: SocketIO.SocketManager!
    fileprivate var socket: SocketIOClient!

    func connect(completion: @escaping (Bool) -> Void) {
        guard let session = sessionController?.current else { return }

        manager = SocketIO.SocketManager(socketURL: URL(string: session.configuration.domainName)!, config: [.log(false), .forceWebsockets(true), .reconnects(true), .reconnectWait(5)])
        socket = manager.defaultSocket

        once(event: .connect) { _ in
            completion(true)
        }

        on(event: .connect) { _ in
            self.websocketDidConnect(socket: self.socket)

            self.authenticate()
        }

        on(event: .disconnect) { _ in
            self.websocketDidDisconnect(socket: self.socket)
        }

        socket.connect()
    }

    func authenticate() {
        guard let session = sessionController?.current, let auth = session.userConfiguration?.chatAuth,
            let playerId = session.user?.id, let username = session.user?.username else { return }

        let data = SocketManagerModels.Authenticate(auth: auth, playerId: playerId, username: username)
        emit(event: .authenticate, with: data)
    }
}

extension SocketManager {
    func emit(event: SocketEvents, with data: SocketData) {
        emit(rawEvent: event.rawValue, with: data)
    }

    func emit(_ socketEventCreator: SocketEventCreating, with data: SocketData) {
        emit(rawEvent: socketEventCreator.eventName, with: data)
    }

    func onConnect(closure: @escaping () -> Void) {
        if socket.status == .connected {
            closure()
        }

        on(event: .connect) { _ in
            closure()
        }
    }

    func on(event: SocketEvents, closure: @escaping NormalSocketCallback) {
        socket.on(event.rawValue) { data, _ in
            closure(data)
        }
    }

    func on(_ socketEventCreator: SocketEventCreating, closure: @escaping NormalSocketCallback) {
        socket.on(socketEventCreator.eventName) { data, _ in
            closure(data)
        }
    }

    func on<T>(_ socketEventCreator: SocketEventCreating, classType: T.Type, closure: @escaping (T) -> Void) where T: Decodable {
        socket.on(socketEventCreator.eventName) { data, _ in
            do {
                let dict = data[0] as! JSON
                let model = try JSONDecoder().decode(classType, from: dict)
                closure(model)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key not found: \(key), \(context)")
            } catch {
                print("Error occurred: \(error)")
            }
        }
    }

    func once(event: SocketEvents, closure: @escaping NormalSocketCallback) {
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
