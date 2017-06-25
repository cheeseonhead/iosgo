//
// Created by Jeffrey Wu on 2017-05-11.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox

extension OGSLoginInfo.TokenInfo: Unboxable
{
    init(unboxer: Unboxer) throws
    {
        accessToken = try unboxer.unbox(key: "access_token")
        tokenType = try unboxer.unbox(key: "token_type")
        expiresIn = try unboxer.unbox(key: "expires_in")
        refreshToken = try unboxer.unbox(key: "refresh_token")
        scope = try unboxer.unbox(key: "scope")
    }
}
