//
// Created by Jeffrey Wu on 2017-05-11.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import PromiseKit

enum HTTPMethod: String {
    case GET
    case POST
}

enum HTTPStatusCode: Int {
    case timeout = -1
    case ok = 200
    case accepted = 202
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case tooManyRequests = 429

    func success() -> Bool {
        switch self {
        case .ok, .accepted:
            return true
        default:
            return false
        }
    }
}

enum HTTPStatusCodeError: Error {
    case unrecognized(code: Int)
}

enum ParseError: Error {
    case urlError(url: String)
    case wrongDataFormat(str: String)
    case wrongUrlResponseFormat(response: URLResponse)
    case typeMismatches(expected: [Any.Type], container: Any)
    case typeMismatch(expected: Any.Type, container: Any)
    case wrongDateFormat(dateStr: String, format: String)
    case unknownEnumType(type: Any.Type)
    case imageError(url: String)
    case propertiesMissingValue([AnyKeyPath])
}

extension ParseError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case let .propertiesMissingValue(keypaths):
            return "Keypaths are nil: \(keypaths)"
        default:
            return localizedDescription
        }
    }
}

struct Empty: Codable {}

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

    func request<T: Decodable>(toUrl url: String, method: HTTPMethod, parameters: [String: String], resultType: T.Type) -> Promise<T> {
        return firstly { () -> Promise<Data> in
            guard let fullURL = URL(string: domainName.appending(url)) else {
                throw ParseError.urlError(url: url)
            }
            let request = createRequest(fullURL: fullURL, method: method, parameters: parameters)

            return send(request: request)
        }.map { result -> T in
            let payload = try JSONDecoder().decode(resultType, from: result)
            return payload
        }
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

    func send(request: URLRequest) -> Promise<Data> {
        let timeout: Promise<(data: Data, response: URLResponse)> = firstly { after(seconds: 4) }.map { _ in
            throw ApiError.timeout(request)
        }

        return firstly {
            race(URLSession.shared.dataTask(.promise, with: request), timeout)
        }.map { result -> (data: Data, response: HTTPURLResponse) in
            guard let resp = result.response as? HTTPURLResponse else {
                throw ParseError.wrongUrlResponseFormat(response: result.response)
            }
            return (data: result.data, response: resp)
        }.map { result -> Data in
            guard let statusCode = HTTPStatusCode(rawValue: result.response.statusCode) else {
                throw HTTPStatusCodeError.unrecognized(code: result.response.statusCode)
            }

            guard statusCode.success() else {
                throw ApiError(statusCode: statusCode, request: request)
            }

            return result.data
        }
    }
}
