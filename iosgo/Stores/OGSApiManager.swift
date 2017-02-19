//
// Created by Jeffrey Wu on 2017-02-17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

enum HTTPMethod: String
{
    case POST
}

enum HTTPStatusCode: Int
{
    case clientError = -1
    case ok = 200
    case badRequest = 401
    case notFound = 404
}

typealias OGSApiResultBlock = (_ success: Bool, _ payload: [String: Any]?, _ error: Error?, _ statusCode: HTTPStatusCode) -> Void

class OGSApiManager
{
    static var sharedInstance = OGSApiManager()

    var domainName: String!

    func request(toUrl url: String, method: HTTPMethod, parameters: [String: String], completion: @escaping OGSApiResultBlock)
    {
        guard let fullURL = URL(string: domainName.appending(url)) else { return }

        var request = URLRequest(url: fullURL)
        request.httpMethod = method.rawValue
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = parameters.stringFromHttpParameters().data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request)
        { data, response, error in
            if let httpResponse = response as? HTTPURLResponse, let data = data
            {
                var json: [String: Any]?
                do
                {
                    json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                    completion(true, json, error, HTTPStatusCode(rawValue: httpResponse.statusCode)!)
                }
                catch _
                {
                    print("Error Occurred")
                }
            }
            else
            {
                completion(false, nil, error, .clientError)
            }
        }

        task.resume()
    }
}
