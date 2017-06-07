//
// Created by Cheese Onhead on 6/6/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

protocol ChallengeStoreProtocol {
    func acceptChallenge(id: Int, completion: () -> Void)
}

class ChallengeWorker {
    struct AcceptResponse {
        var success: Bool
    }

    fileprivate var challengeStore: ChallengeStore

    init(challengeStore: ChallengeStore) {
        self.challengeStore = challengeStore
    }

    func acceptChallenge(id: Int, completion: (AcceptResponse) -> Void) {
        challengeStore.acceptChallenge(id: id) { storeResponse in
            let response = acceptResponse(from: storeResponse)
            completion(response)
        }
    }
}

// MARK: - Model Translation
extension ChallengeWorker {
    func acceptResponse(from storeResponse: ChallengeStore.AcceptResponse) -> AcceptResponse {
        let response = AcceptResponse(success: storeResponse.success)

        return response
    }
}
