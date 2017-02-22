//
// Created by Jeffrey Wu on 2017-02-17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class OGSOauthApiStore
{
    func login(with username: String, password: String)
    {
        var url = "oauth2/token/"

        var params = [
            "client_id": OGSApiManager.sharedInstance.clientId!,
            "client_secret": OGSApiManager.sharedInstance.clientSecret!,
            "grant_type": "password",
            "username": username,
            "password": password,
        ]

        OGSApiManager.sharedInstance.request(toUrl: url, method: .POST, parameters: params)
        { _, _, _ in

        }
    }
}
