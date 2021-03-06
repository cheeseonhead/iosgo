//
// Created by Jeffrey Wu on 2017-05-10.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

enum SessionError: Error, LocalizedError {
    case noCurrentConfiguration

    var errorDescription: String? {
        switch self {
        case .noCurrentConfiguration:
            return "There isn't a user object in current session."
        }
    }
}

struct OGSSession {
    enum Key {
        static let user = "user"
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
    }

    fileprivate var userDefault: UserDefaults = UserDefaults.standard

    var accessToken: String? {
        set {
            userDefault.set(newValue, forKey: Key.accessToken)
        }

        get {
            return userDefault.string(forKey: Key.accessToken)
        }
    }

    var refreshToken: String? {
        set {
            userDefault.set(newValue, forKey: Key.refreshToken)
        }

        get {
            return userDefault.string(forKey: Key.refreshToken)
        }
    }

    var userConfiguration: Config?

    var user: User? {
        return userConfiguration?.user
    }

    var configuration: OGSConfigurationProtocol

    var tokensExists: Bool {
        return accessToken != nil && refreshToken != nil
    }

    init(configuration: OGSConfigurationProtocol) {
        self.configuration = configuration
    }
}
