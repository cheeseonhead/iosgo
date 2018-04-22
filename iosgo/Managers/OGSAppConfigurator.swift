//
// Created by Jeffrey Wu on 2017-02-18.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import PromiseKit

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
    func configureApp() -> Promise<ConfigureResult> {
        return configureSessionController()
    }

    func configureSessionController() -> Promise<ConfigureResult> {
        OGSSessionController.sharedInstance.current = session

        return OGSSessionController.sharedInstance.initialize()
            .then { _ in self.configureSocketManager() }
    }

    func configureSocketManager() -> Promise<ConfigureResult> {
        SocketManager.sharedInstance.sessionController = OGSSessionController.sharedInstance

        return SocketManager.sharedInstance.connect().map { _ in .loggedIn }
    }
}
