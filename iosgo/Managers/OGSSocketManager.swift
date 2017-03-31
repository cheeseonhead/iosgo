//
// Created by Cheese Onhead on 3/5/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Starscream

class OGSSocketManager
{
    var socketAddress: String!

    fileprivate var socket: WebSocket!

    func connect()
    {
        socket = WebSocket(url: URL(string: socketAddress)!)

    }
}

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
