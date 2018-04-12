//
// Created by Cheese Onhead on 6/6/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

class ChallengeAPI {
    struct AcceptResponse {
        var success: Bool
        var errorMessage: String?
    }

    fileprivate var apiStore: OGSApiStore

    init(apiStore: OGSApiStore) {
        self.apiStore = apiStore
    }

    func acceptChallenge(id: Int, completion: @escaping (_: AcceptResponse) -> Void) {
        let url = ChallengeURLGenerator.accept(challengeId: id)

        apiStore.request(toUrl: url, method: .POST, parameters: [:]) { statusCode, payload, _ in
            var success: Bool!

            switch statusCode {
            case .accepted:
                success = true
            default:
                success = false
            }

            var errorMessage: String?
            switch statusCode {
            case .forbidden:
                errorMessage = payload?["error"] as? String
            default:
                break
            }

            let response = AcceptResponse(success: success, errorMessage: errorMessage)
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
