//
// Created by Cheese Onhead on 3/5/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import SocketIO

enum SeekGraph: String
{
    case connect = "seek_graph/connect"
}

class OGSSocketManager
{
    var socketAddress: String!

    fileprivate var socket: SocketIOClient!

    func connect()
    {
        socket = SocketIOClient(socketURL: URL(string: socketAddress)!, config: [.forceWebsockets(true)])

        socket.on(<#T##event: String##Swift.String#>, callback: <#T##@escaping NormalCallback##@escaping SocketIO.NormalCallback#>)
    }
}

// MARK: - Handlers
extension OGSSocketManager
{
    func websocketDidConnect(socket: socket)
    {
        print("just connected!")
    }

    func websocketDidDisconnect(socket: socket, error: NSError?)
    {
    }

    func websocketDidReceiveMessage(socket: socket, text: String)
    {
        
    }

    func websocketDidReceiveData(socket: socket, data: Data)
    {
    }

}
