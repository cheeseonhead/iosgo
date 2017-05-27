//
// Created by Jeffrey Wu on 2017-02-17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

enum HTTPMethod: String
{
    case GET
    case POST
}

enum HTTPStatusCode: Int
{
    case clientError = -1
    case ok = 200
    case badRequest = 400
    case unauthorized = 401
    case notFound = 404
}

class OGSApiManager
{
    static var sharedInstance = OGSApiManager(apiStore: OGSApiStore(session: OGSSessionController.sharedInstance.current))

    var apiStore: OGSApiStore

    var domainName: String!
    var clientId: String!
    var clientSecret: String!
    var accessToken: String?
    var refreshToken: String?

    required init(apiStore: OGSApiStore)
    {
        self.apiStore = apiStore
    }
}
