//
// Created by Cheese Onhead on 3/30/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

struct OGSLoginInfo
{
    var result: GetTokenResult

    enum GetTokenResult
    {
        case success
        case error(type: ApiErrorType)
    }

    struct TokenInfo
    {
        var accessToken: String
        var tokenType: String
        var expiresIn: Int
        var refreshToken: String
        var scope: String
    }
}
