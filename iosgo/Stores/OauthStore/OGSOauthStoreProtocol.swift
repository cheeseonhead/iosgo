//
// Created by Jeffrey Wu on 2017-02-17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

struct OGSOauthStore
{
    enum GetTokenResult
    {
        case success(info: TokenInfo)
        case error(type: ErrorType)
    }

    struct TokenInfo
    {
        var accessToken: String?
        var tokenType: String?
        var expiresIn: String?
        var refreshToken: String?
        var scope: String?
    }

    enum ErrorType
    {
        case invalidLoginInfo
        case unknownError
    }
}

protocol OGSOauthStoreProtocol
{
    func getToken(with username: String, password: String, completion: @escaping (OGSOauthStore.GetTokenResult) -> Void)
}
