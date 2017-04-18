//
// Created by Cheese Onhead on 3/5/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import SocketIO

class OGSSocketManager
{
    var socketAddress: String!

    fileprivate var socket: WebSocket!

    func connect()
    {
        socket = SocketIOClient(socketURL: URL(string: socketAddress)!, config: [.forceWebsockets(true)])
    }
}

// MARK: - Handlers
extension OGSSocketManager: WebSocketDelegate
{
    func websocketDidConnect(socket: WebSocket)
    {
        print("just connected!")
    }

    func websocketDidDisconnect(socket: WebSocket, error: NSError?)
    {
    }

    func websocketDidReceiveMessage(socket: WebSocket, text: String)
    {
        
    }

    func websocketDidReceiveData(socket: WebSocket, data: Data)
    {
    }

}
