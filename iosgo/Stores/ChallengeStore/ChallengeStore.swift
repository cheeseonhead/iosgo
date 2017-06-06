//
// Created by Cheese Onhead on 6/6/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

class ChallengeStore
{
    struct AcceptResponse
    {
        var success: Bool
    }

    fileprivate var apiStore: OGSApiStore

    init(apiStore: OGSApiStore)
    {
        self.apiStore = apiStore
    }

    func acceptChallenge(id _: Int, completion _: (_: AcceptResponse) -> Void)
    {
    }
}
