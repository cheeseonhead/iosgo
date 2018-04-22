//
// Created by Cheese Onhead on 6/6/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import PromiseKit

protocol ChallengeStoreProtocol {
    func acceptChallenge(id: Int, completion: () -> Void)
}

class ChallengeWorker {
    struct AcceptResponse {
        var success: Bool
        var errorMessage: String?
    }

    fileprivate var challengeStore: ChallengeAPI

    init(challengeStore: ChallengeAPI) {
        self.challengeStore = challengeStore
    }

    func acceptChallenge(id: Int) -> Promise<Empty> {
        return challengeStore.acceptChallenge(id: id)
    }
}
