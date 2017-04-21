//
// Created by Cheese Onhead on 3/5/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import SocketIO

class OGSSocketManager
{
    enum Event
    {
        static let connect = "connect"

        enum SeekGraph
        {
            static let connect = "seek_graph/connect"
            static let global = "seekgraph/global"
        }
    }

    static var sharedInstance = OGSSocketManager()

    var socketAddress: String!

    fileprivate var socket: SocketIOClient!

    func connect()
    {
        socket = SocketIOClient(socketURL: URL(string: socketAddress)!, config: [.forceWebsockets(true)])

        socket.on(Event.connect)
        { _, _ in
            self.websocketDidConnect(socket: self.socket)
        }

        socket.connect()
    }
}

// MARK: - Handlers
extension OGSSocketManager
{
    func websocketDidConnect(socket _: SocketIOClient)
    {
        print("just connected!")
    }

    func websocketDidDisconnect(socket _: SocketIOClient, error _: NSError?)
    {
    }

    func websocketDidReceiveMessage(socket _: SocketIOClient, text _: String)
    {
    }

    func websocketDidReceiveData(socket _: SocketIOClient, data _: Data)
    {
    }
}
