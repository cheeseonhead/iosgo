//
// Created by Cheese Onhead on 5/27/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

struct OGSUser: Codable {
    var id: Int
    var username: String
    var rank: Int

    enum CodingKeys: String, CodingKey {
        case id
        case username
        case rank = "ranking"
    }
}
