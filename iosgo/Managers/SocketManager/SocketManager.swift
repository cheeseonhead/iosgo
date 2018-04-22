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

    func connect() -> Promise<Bool> {

        let promise = Promise<Bool> { seal in
            guard let session = sessionController?.current else {
                seal.reject(SocketError.noCurrentSession)
                return
            }

            manager = SocketIO.SocketManager(socketURL: URL(string: session.configuration.domainName)!, config: [.log(false), .forceWebsockets(true), .reconnects(true), .reconnectWait(5)])
            socket = manager.defaultSocket

            _ = firstly {
                once(event: .connect, resultType: Empty.self)
            }.done { _ in
            }

            _ = firstly {
                on(event: .connect)
            }.done { _ in
                self.websocketDidConnect(socket: self.socket)

                self.authenticate()
            }

            _ = firstly {
                on(event: .disconnect)
            }.done { _ in
                self.websocketDidDisconnect(socket: self.socket)
            }

            socket.connect()

            socket.once(SocketEvents.connect.rawValue) { _, _ in
                seal.fulfill(true)
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

        _ = firstly {
            on(event: .connect)
        }.done { _ in
            closure()
        }
    }

    func on(event: SocketEvents) -> Guarantee<Any> {
        return on(rawEventName: event.rawValue)
    }

    func on(_ socketEventCreator: SocketEventCreating) -> Guarantee<Any> {
        return on(rawEventName: socketEventCreator.eventName)
    }

    private func on(rawEventName: SocketEvent) -> Guarantee<Any> {
        let guarantee = Guarantee<Any> { resolve in
            socket.on(rawEventName) { data, _ in
                resolve(data)
                return
            }
        }

        return guarantee
    }

    func on<T: Decodable>(event: SocketEvents, returnType: T.Type) -> Promise<T> {
        return on(rawEventName: event.rawValue, returnType: returnType)
    }

    func on<T: Decodable>(_ socketEventCreator: SocketEventCreating, returnType: T.Type) -> Promise<T> {
        return on(rawEventName: socketEventCreator.eventName, returnType: returnType)
    }

    private func on<T: Decodable>(rawEventName: SocketEvent, returnType: T.Type) -> Promise<T> {
        let promise = Promise<T> { seal in
            socket.on(rawEventName) { data, _ in
                do {
                    let object = try self.convert(to: returnType, from: data)
                    seal.fulfill(object)
                } catch {
                    seal.reject(error)
                }
            }
        }

        return promise
    }

    func once<T: Decodable>(event: SocketEvents, resultType: T.Type) -> Promise<T> {

        let promise = Promise<T> { seal in
            socket.once(event.rawValue) { data, _ in
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
}

// MARK: - Private

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
