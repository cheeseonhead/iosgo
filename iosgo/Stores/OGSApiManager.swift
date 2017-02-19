//
// Created by Jeffrey Wu on 2017-02-17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

enum HTTPMethod: String
{
    case POST
}

typealias OGSApiResultBlock = (Bool, [String: Any]?, Error?, Int) -> Void

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
                    completion(true, json, error, httpResponse.statusCode)
                }
                catch _
                {
                    print("Error Occurred")
                }
            }
            else
            {
                completion(false, nil, error, -1)
            }
        }

        task.resume()
    }
}
