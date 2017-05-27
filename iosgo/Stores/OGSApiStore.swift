//
// Created by Jeffrey Wu on 2017-05-11.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

typealias OGSApiResultBlock = (_ statusCode: HTTPStatusCode, _ payload: [String: Any]?, _ error: Error?) -> Void

class OGSApiStore
{
    var session: OGSSession
    var clientID: String
    {
        session.configuration.clientID
    }
    var clientSecret: String! {
        session.configuration.clientSecret
    }
    var domainName: String
    {
        session.configuration.domainName
    }
    var accessToken: String
    {
        session.accessToken
    }

    required init(session: OGSSession)
    {
        self.session = session
    }

    func request(toUrl url: String, method: HTTPMethod, parameters: [String: String], completion: @escaping OGSApiResultBlock)
    {
        guard let fullURL = URL(string: domainName.appending(url)) else { return }

        let request = createRequest(fullURL: fullURL, method: method, parameters: parameters)

        send(request: request, completion: completion)
    }

    func createRequest(fullURL: URL, method: HTTPMethod, parameters: [String: String]) -> URLRequest
    {
        var request = URLRequest(url: fullURL)
        request.httpMethod = method.rawValue
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = parameters.stringFromHttpParameters().data(using: .utf8)

        return request
    }

    func send(request: URLRequest, completion: @escaping OGSApiResultBlock)
    {
        let task = URLSession.shared.dataTask(with: request)
        { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, let data = data else
            {
                completion(.clientError, nil, error)
                return
            }

            do
            {
                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                completion(HTTPStatusCode(rawValue: httpResponse.statusCode)!, json, error)
            }
            catch _
            {
                print("Error Occurred")
            }
        }

        task.resume()
    }
}
