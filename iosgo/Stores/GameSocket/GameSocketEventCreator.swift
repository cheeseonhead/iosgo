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
        }
    }

    enum EventType {
        case move, clock
    }

    var gameId: Int
    var eventType: EventType
}
