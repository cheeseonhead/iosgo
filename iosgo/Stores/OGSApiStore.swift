//
// Created by Jeffrey Wu on 2017-05-11.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

typealias OGSApiResultBlock = (_ statusCode: HTTPStatusCode, _ payload: [String: Any]?, _ error: Error?) -> Void

class OGSApiStore
{
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
