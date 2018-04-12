//
// Created by Jeffrey Wu on 2017-02-18.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

protocol OGSUserSettingsStoreProtocol {
    var accessToken: String? { get set }
    var refreshToken: String? { get set }
}

enum ConfigureResult {
    case loggedIn, loggedOut
}

class OGSAppConfigurator {
    fileprivate var session: OGSSession

    required init(session: OGSSession) {
        self.session = session
    }
}

// MARK: - Configure app

extension OGSAppConfigurator {
    func configureApp(completion: @escaping (ConfigureResult) -> Void) {
        configureSessionController(completion: completion)
    }

    func configureSessionController(completion: @escaping (ConfigureResult) -> Void) {
        OGSSessionController.sharedInstance.current = session
        OGSSessionController.sharedInstance.initialize { result in
            switch result {
            case .success:
                self.configureSocketManager(completion: completion)
            case .error:
                completion(.loggedOut)
            }
        }
    }

    func configureSocketManager(completion: @escaping (ConfigureResult) -> Void) {
        SocketManager.sharedInstance.sessionController = OGSSessionController.sharedInstance

        SocketManager.sharedInstance.connect { success in
            if success {
                completion(.loggedIn)
            } else {
                completion(.loggedOut)
            }
        }
    }
}
