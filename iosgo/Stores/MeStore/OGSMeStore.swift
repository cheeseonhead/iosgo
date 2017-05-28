//
// Created by Cheese Onhead on 5/27/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class OGSMeStore
{
    static let url = "api/v1/me/"

    var apiStore: OGSApiStore

    required init(apiStore: OGSApiStore)
    {
        self.apiStore = apiStore
    }
}
