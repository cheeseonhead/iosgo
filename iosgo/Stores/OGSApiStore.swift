//
// Created by Jeffrey Wu on 2017-05-11.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
}

enum HTTPStatusCode: Int {
    case ok = 200
    case accepted = 202
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case tooManyRequests = 429
}

enum ApiError: Error {
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case tooManyRequests
    case unknown
    //
    //    init(statusCode: HTTPStatusCode) {
    //        switch statusCode {
    //        case .clientError:
    //            self = .genericError(message: NSLocalizedString("Please check your internet connection and try again.", comment: ""))
    //        case .badRequest:
    //            self = .genericError(message: NSLocalizedString("The request could not be processed, please report as a bug to the developers", comment: ""))
    //        case .unauthorized:
    //            self = .genericError(message: NSLocalizedString("You are not authorized to do the request.", comment: ""))
    //        case .forbidden:
    //            self = .genericError(message: NSLocalizedString("You are forbidden to do this action", comment: ""))
    //        case .notFound:
    //            self = .genericError(message: NSLocalizedString("The action you are trying to do doesn't exist.", comment: ""))
    //        case .tooManyRequests:
    //            self = .genericError(message: NSLocalizedString("You are making too many requests.", comment: ""))
    //        default:
    //            self = .genericError(message: NSLocalizedString("An unknown error has Occured.", comment: ""))
    //        }
    //    }
}

typealias OGSApiResultBlock = (_ statusCode: HTTPStatusCode, _ payload: [String: Any]?, _ error: Error?) -> Void

class OGSApiStore {
    var sessionController: OGSSessionController
    var session: OGSSession {
        return sessionController.current
    }

    var clientID: String {
        return session.configuration.clientID
    }

    var clientSecret: String! {
        return session.configuration.clientSecret
    }

    var domainName: String {
        return session.configuration.domainName
    }

    var accessToken: String? {
        get {
            return session.accessToken
        }
        set {
            sessionController.current.accessToken = newValue
        }
    }

    var refreshToken: String? {
        get {
            return session.refreshToken
        }
        set {
            sessionController.current.refreshToken = newValue
        }
    }

    required init(sessionController: OGSSessionController) {
        self.sessionController = sessionController
    }

    func request(toUrl url: String, method: HTTPMethod, parameters: [String: String], completion: @escaping OGSApiResultBlock) {
        guard let fullURL = URL(string: domainName.appending(url)) else { return }

        let request = createRequest(fullURL: fullURL, method: method, parameters: parameters)

        send(request: request, completion: completion)
    }

    private func createRequest(fullURL: URL, method: HTTPMethod, parameters: [String: String]) -> URLRequest {
        var request = URLRequest(url: fullURL)
        request.httpMethod = method.rawValue
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        if let token = accessToken {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        request.httpBody = parameters.stringFromHttpParameters().data(using: .utf8)

        return request
    }

    private func send(request _: URLRequest, completion _: @escaping OGSApiResultBlock) {
        //        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        //            guard let httpResponse = response as? HTTPURLResponse, let data = data else {
        //                completion(.clientError, nil, error)
        //                return
        //            }
        //
        //            do {
        //                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        //                completion(HTTPStatusCode(rawValue: httpResponse.statusCode)!, json, error)
        //            } catch _ {
        //                print("Error Occurred")
        //            }
        //        }
        //
        //        task.resume()
    }
}
