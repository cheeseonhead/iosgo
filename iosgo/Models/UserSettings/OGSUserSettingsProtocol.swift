//
// Created by Jeffrey Wu on 2017-02-26.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

protocol OGSUserSettingsProtocol: OGSVersionedCoding
{
    var accessToken: String? { get set }
    var refreshToken: String? { get set }
}
