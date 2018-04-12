//
//  OGSSocketEvents.swift
//  iosgo
//
//  Created by Cheese Onhead on 7/2/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

typealias SocketEvent = String

enum SocketEvents: SocketEvent {
    case connect
    case disconnect

    case authenticate
    case seekGraphConnect = "seek_graph/connect"
    case seekGraphGlobal = "seekgraph/global"
}
