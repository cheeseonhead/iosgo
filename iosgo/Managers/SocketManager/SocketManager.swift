//
// Created by Cheese Onhead on 3/5/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import SocketIO
import PromiseKit

enum SocketError: Error {
    case noCurrentSession
}

class SocketManager {
    static var sharedInstance = SocketManager()

    var sessionController: OGSSessionController?
    var isConnected = false

    private var manager: SocketIO.SocketManager!
    fileprivate var socket: SocketIOClient!

    func connect() -> Promise<()> {

        let promise = Promise<()> { seal in
            guard let session = sessionController?.current else {
                seal.reject(SocketError.noCurrentSession)
                return
            }

            manager = SocketIO.SocketManager(socketURL: URL(string: session.configuration.domainName)!, config: [.log(false), .forceWebsockets(true), .reconnects(true), .reconnectWait(5)])
            socket = manager.defaultSocket

            on(event: .connect) { [weak self] guarantee in
                guarantee.done { _ in
                    self?.websocketDidConnect()
                    self?.authenticate()
                }
            }

            on(event: .disconnect) { [weak self] guarantee in
                guarantee.done { _ in
                    self?.websocketDidDisconnect()
                }
            }

            socket.connect()

            socket.once(SocketEvents.connect.rawValue) { _, _ in
                seal.fulfill(())
            }
        }

        return promise
    }

    func authenticate() {
        guard let session = sessionController?.current, let auth = session.userConfiguration?.chatAuth,
            let playerId = session.user?.id, let username = session.user?.username else { return }

        let data = SocketManagerModels.Authenticate(auth: auth, playerId: playerId, username: username)
        emit(event: .authenticate, with: data)
    }
}

// MARK: - Emit
extension SocketManager {

    func emit(event: SocketEvents, with data: SocketData) {
        emit(rawEvent: event.rawValue, with: data)
    }

    func emit(_ socketEventCreator: SocketEventCreating, with data: SocketData) {
        emit(rawEvent: socketEventCreator.eventName, with: data)
    }
}

// MARK: - On
extension SocketManager {

    func onceConnected() -> Guarantee<Any> {
        if socket.status == .connected {
            return Guarantee<Any> { seal in
                seal(())
            }
        } else {
            return once(event: .connect)
        }
    }

    func on(event: SocketEvents, closure: @escaping (Guarantee<Any>) -> Void) {
        on(rawEventName: event.rawValue, closure: closure)
    }

    func on(_ socketEventCreator: SocketEventCreating, closure: @escaping (Guarantee<Any>) -> Void) {
        on(rawEventName: socketEventCreator.eventName, closure: closure)
    }

    func once(event: SocketEvents) -> Guarantee<Any> {
        return once(rawEventName: event.rawValue)
    }

    func on<T: Decodable>(event: SocketEvents, resultType: T.Type, closure: @escaping (Promise<T>) -> Void) {
        on(rawEventName: event.rawValue, resultType: resultType, closure: closure)
    }

    func on<T: Decodable>(_ socketEventCreator: SocketEventCreating, resultType: T.Type, closure: @escaping (Promise<T>) -> Void) {
        on(rawEventName: socketEventCreator.eventName, resultType: resultType, closure: closure)
    }

    func once<T: Decodable>(event: SocketEvents, resultType _: T.Type) -> Promise<T> {
        return once(rawEventName: event.rawValue, resultType: T.self)
    }
}

// MARK: - Any Raw
private extension SocketManager {
    func emit(rawEvent: SocketEvent, with data: SocketData) {
        if !isConnected {

            _ = connect().done { _ in
                self.socket.emit(rawEvent, data)
            }
        } else {
            socket.emit(rawEvent, data)
        }
    }

    func on(rawEventName: SocketEvent, closure: @escaping (Guarantee<Any>) -> Void) {
        var guarantee = once(rawEventName: rawEventName)

        guarantee = guarantee.map { [weak self] data in
            self?.on(rawEventName: rawEventName, closure: closure)
            return data
        }

        closure(guarantee)
    }

    func once(rawEventName: SocketEvent) -> Guarantee<Any> {
        let guarantee = Guarantee<Any> { resolver in
            socket.once(rawEventName) { data, _ in
                resolver(data)
                return
            }
        }

        return guarantee
    }
}

// MARK: - Decodable Raw
private extension SocketManager {
    func once<T: Decodable>(rawEventName: SocketEvent, resultType: T.Type) -> Promise<T> {
        let promise = Promise<T> { seal in
            socket.once(rawEventName) { data, _ in
                do {
                    let object = try self.convert(to: resultType, from: data)
                    seal.fulfill(object)
                } catch {
                    seal.reject(error)
                }
            }
        }

        return promise
    }

    func on<T: Decodable>(rawEventName: SocketEvent, resultType: T.Type, closure: @escaping (Promise<T>) -> Void) {
        let promise = once(rawEventName: rawEventName, resultType: resultType)

        let newPromise = promise.get { [weak self] _ in
            self?.on(rawEventName: rawEventName, resultType: resultType, closure: closure)
        }

        closure(newPromise)
    }
}

// MARK: - Handlers

extension SocketManager {
    func websocketDidConnect() {
        isConnected = true
    }

    func websocketDidDisconnect() {
        isConnected = false
    }

    func websocketDidReceiveMessage(socket _: SocketIOClient, text _: String) {
    }

    func websocketDidReceiveData(socket _: SocketIOClient, data _: Data) {
    }
}

// MARK: - Helpers
private extension SocketManager {
    func convert<T: Decodable>(to resultType: T.Type, from data: [Any]) throws -> T {
        guard let dict = data[0] as? JSON else {
            throw ParseError.typeMismatch(expected: JSON.self, container: data[0])
        }

        let object = try JSONDecoder().decode(resultType.self, from: dict)

        return object
    }
}
