//
// Created by Jeffrey Wu on 2017-02-26.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import UIKit

protocol OGSChooseGameListGamesWorkerDelegate: class {
    func sendGameList(_ gameList: [OGSChallenge])
}

protocol OGSListGamesStoreDelegate: class {
    func add(_ newChallenges: [OGSChallenge])
    func delete(challengeID: Int)
    func delete(gameID: Int)
}

protocol OGSListGamesStoreProtocol {
    weak var delegate: OGSListGamesStoreDelegate? { set get }
    var socketManager: SocketManager! { set get }

    func connect()
}

class OGSChooseGameListGamesWorker {
    weak var delegate: OGSChooseGameListGamesWorkerDelegate?
    var seekGraphStore: OGSListGamesStoreProtocol!

    fileprivate var challenges: [OGSChallenge] = []

    required init(store: OGSListGamesStoreProtocol) {
        seekGraphStore = store
        seekGraphStore.delegate = self
        seekGraphStore.socketManager = SocketManager.sharedInstance
    }

    func connect() {
        seekGraphStore.connect()
    }

    func challenge(at indexPath: IndexPath) -> OGSChallenge? {
        guard indexPath.row < challenges.count else {
            return nil
        }

        return challenges[indexPath.row]
    }
}

// MARK: Store Delegate
extension OGSChooseGameListGamesWorker: OGSListGamesStoreDelegate {
    func add(_ newChallenges: [OGSChallenge]) {
        challenges.append(contentsOf: newChallenges)
        sendResponse()
    }

    func delete(challengeID: Int) {
        try? challenges.remove { $0.id == challengeID }
        sendResponse()
    }

    func delete(gameID: Int) {
        try? challenges.remove { $0.gameId == gameID }
        sendResponse()
    }

    func sendResponse() {
        delegate?.sendGameList(challenges)
    }
}
