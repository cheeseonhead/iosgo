//
//  Config.swift
//  iosgo
//
//  Created by Jeffrey Wu on 2018-04-12.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation

struct Config: Codable {
    /// Despite the name, it's used for game authentication also.
    var chatAuth: String
    var user: User

    enum CodingKeys: String, CodingKey {
        case chatAuth = "chat_auth"
        case user
    }
}
