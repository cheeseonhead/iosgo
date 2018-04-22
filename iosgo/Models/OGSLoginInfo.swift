//
// Created by Cheese Onhead on 3/30/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

struct OGSLoginInfo: Codable {
    var accessToken: String
    var tokenType: String
    var expiresIn: Int
    var refreshToken: String
    var scope: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case scope
    }
}
