//
//  Config.swift
//  iosgo
//
//  Created by Jeffrey Wu on 2018-04-12.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation

struct Config: Codable {
    var chatAuth: String
    var user: OGSUser

    enum Keys: String, CodingKey {
        case chatAuth = "chat_auth"
        case user
    }
}
