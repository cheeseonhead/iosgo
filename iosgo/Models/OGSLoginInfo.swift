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
        case success(info: TokenInfo)
        case error(type: ErrorType)
    }

    struct TokenInfo
    {
        var accessToken: String
        var tokenType: String
        var expiresIn: Int
        var refreshToken: String
        var scope: String
    }

    enum ErrorType
    {
        case invalidLoginInfo
        case unknownError
        case clientError
    }
}
