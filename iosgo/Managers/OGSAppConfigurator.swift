//
// Created by Jeffrey Wu on 2017-02-18.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

protocol OGSUserSettingsStoreProtocol {
    var accessToken: String? { get set }
    var refreshToken: String? { get set }
}

class OGSAppConfigurator {
    fileprivate var session: OGSSession

    required init(session: OGSSession) {
        self.session = session
    }
}

// MARK: - Configure app
extension OGSAppConfigurator {
    func configureApp(completion: @escaping (Bool) -> Void) {
        configureSessionController()
        configureSocketManager(completion: completion)
    }

    func configureSessionController() {
        OGSSessionController.sharedInstance.current = session
    }

    func configureSocketManager(completion: @escaping (Bool) -> Void) {
        OGSSocketManager.sharedInstance.socketAddress = session.configuration.domainName

        OGSSocketManager.sharedInstance.connect(completion: completion)
    }
}
