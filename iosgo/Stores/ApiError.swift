//
//  ApiError.swift
//  iosgo
//
//  Created by Cheese Onhead on 2018-04-22.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation

enum ApiError: Error {
    case badRequest(String)
    case unauthorized(String)
    case forbidden(String)
    case notFound(String)
    case tooManyRequests(String)
    case unknown(String)

    init(statusCode: HTTPStatusCode, url: String) {
        switch statusCode {
        case .badRequest:
            self = .badRequest(url)
        case .unauthorized:
            self = .unauthorized(url)
        case .forbidden:
            self = .forbidden(url)
        case .notFound:
            self = .notFound(url)
        case .tooManyRequests:
            self = .tooManyRequests(url)
        default:
            self = .unknown(url)
        }
    }
}

extension ApiError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case let .badRequest(url):
            return "Bad request was made to url: \(url)"
        case let .unauthorized(url):
            return "Unauthorized request was made to url: \(url)"
        case let .forbidden(url):
            return "Forbidden request was made to url: \(url)"
        case let .notFound(url):
            return "Could not find url:\(url)"
        case let .tooManyRequests(url):
            return "Too many requests were made to \(url)"
        case let .unknown(url):
            return "An unknown error occurred while making requests to url: \(url)"
        }
    }
}
