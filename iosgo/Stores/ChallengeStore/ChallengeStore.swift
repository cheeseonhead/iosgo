//
// Created by Cheese Onhead on 6/6/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

class ChallengeStore {
    struct AcceptResponse {
        var success: Bool
    }

    fileprivate var apiStore: OGSApiStore

    init(apiStore: OGSApiStore) {
        self.apiStore = apiStore
    }

    func acceptChallenge(id: Int, completion: @escaping (_: AcceptResponse) -> Void) {
        let url = ChallengeURLGenerator.accept(challengeId: id)

        apiStore.request(toUrl: url, method: .POST, parameters: [:]) { statusCode, _, _ in
            var response = AcceptResponse(success: false)
            switch statusCode {
            case .accepted:
                response.success = true
            default:
                break
            }

            completion(response)
        }
    }
}

private class ChallengeURLGenerator {
    private static let baseURL = "api/v1/challenges/"

    class func accept(challengeId: Int) -> String {
        return "\(baseURL)\(challengeId)/accept"
    }
}
