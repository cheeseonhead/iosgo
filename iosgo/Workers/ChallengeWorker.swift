//
// Created by Cheese Onhead on 6/6/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

protocol ChallengeStoreProtocol
{
    func acceptChallenge(id: Int, completion: () -> Void)
}

class ChallengeWorker
{
    fileprivate var challengeStore: ChallengeStore

    init(challengeStore: ChallengeStore)
    {
        self.challengeStore = challengeStore
    }

    func acceptChallenge(id _: Int)
    {
    }
}
