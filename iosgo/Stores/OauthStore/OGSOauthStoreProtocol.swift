//
// Created by Jeffrey Wu on 2017-02-17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

struct OGSOauthStore
{
    struct LoginResult
    {
    }
}

protocol OGSOauthStoreProtocol
{
    func login(with username: String, password: String)
}
