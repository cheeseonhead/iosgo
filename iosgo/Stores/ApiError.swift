//
//  ApiError.swift
//  iosgo
//
//  Created by Cheese Onhead on 2018-04-22.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation

enum ApiError: Error {
    case timeout(URLRequest)
    case badRequest(URLRequest)
    case unauthorized(URLRequest)
    case forbidden(URLRequest)
    case notFound(URLRequest)
    case tooManyRequests(URLRequest)
    case notFailure(URLRequest)

    init(statusCode: HTTPStatusCode, request: URLRequest) {
        switch statusCode {
        case .badRequest:
            self = .badRequest(request)
        case .unauthorized:
            self = .unauthorized(request)
        case .forbidden:
            self = .forbidden(request)
        case .notFound:
            self = .notFound(request)
        case .tooManyRequests:
            self = .tooManyRequests(request)
        case .timeout:
            self = .timeout(request)
        case .ok: fallthrough
        case .accepted:
            self = .notFailure(request)
        }
    }
}

extension ApiError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case let .badRequest(url):
            return "Bad request: \(url.cURL)"
        case let .unauthorized(url):
            return "Unauthorized request: \(url.cURL)"
        case let .forbidden(url):
            return "Forbidden request: \(url.cURL)"
        case let .notFound(url):
            return "Could not find url for request:\(url.cURL)"
        case let .tooManyRequests(url):
            return "Too many requests: \(url.cURL)"
        case let .timeout(url):
            return "Timed out for request: \(url.cURL)"
        case let .notFailure(url):
            return "Not failure but still threw ApiError for request: \(url.cURL)"
        }
    }
}
