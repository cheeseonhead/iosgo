//
// Created by Cheese Onhead on 6/6/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import PromiseKit

class ChallengeAPI {
    struct AcceptResponse {
        var success: Bool
        var errorMessage: String?
    }

    fileprivate var apiStore: OGSApiStore

    init(apiStore: OGSApiStore) {
        self.apiStore = apiStore
    }

    func acceptChallenge(id: Int) -> Promise<Empty> {
        let url = ChallengeURLGenerator.accept(challengeId: id)

        return apiStore.request(toUrl: url, method: .POST, parameters: [:], resultType: Empty.self)
    }
}

private class ChallengeURLGenerator {
    private static let baseURL = "api/v1/challenges/"

    class func accept(challengeId: Int) -> String {
        return "\(baseURL)\(challengeId)/accept"
    }
}
