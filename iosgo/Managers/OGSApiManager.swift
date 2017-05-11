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
    static var sharedInstance = OGSApiManager(apiStore: OGSApiStore())

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

    func request(toUrl url: String, method: HTTPMethod, parameters: [String: String], completion: @escaping OGSApiResultBlock)
    {
        guard let fullURL = URL(string: domainName.appending(url)) else { return }

        let request = createRequest(fullURL: fullURL, method: method, parameters: parameters)

        apiStore.send(request: request, completion: completion)
    }

    func createRequest(fullURL: URL, method: HTTPMethod, parameters: [String: String]) -> URLRequest
    {
        var request = URLRequest(url: fullURL)
        request.httpMethod = method.rawValue
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        if let token = accessToken
        {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        request.httpBody = parameters.stringFromHttpParameters().data(using: .utf8)

        return request
    }
}
