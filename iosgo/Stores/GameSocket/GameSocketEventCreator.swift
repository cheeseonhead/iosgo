//
//  GameSocketEventCreator.swift
//  iosgo
//
//  Created by Cheese Onhead on 7/2/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation

struct GameSocketEventCreator: SocketEventCreating {
    var eventName: SocketEvent {
        switch eventType {
        case .clock:
            return "game/\(gameId)/clock"
        case .move:
            return "game/\(gameId)/move"
        case .connect:
            return "game/connect"
        case .gamedata:
            return "game/\(gameId)/gamedata"
        }
    }

    enum EventType {
        case move, clock, connect, gamedata
    }

    var gameId: Int
    var eventType: EventType
}
