//
// Created by Jeffrey Wu on 2017-02-26.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

protocol OGSUserSettingsStoreProtocol
{
    func save(accessToken: String)
    func save(refreshToken: String)
    func getUserSettings() -> OGSUserSettingsProtocol
}
