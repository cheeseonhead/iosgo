//
// Created by Jeffrey Wu on 2017-02-27.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import UIKit
import Unbox
import Starscream

class OGSSeekGraphSocketStore
{
    enum ModelType
    {
        case challengeList([OGSSeekGraphSocketStoreModel.Challenge])
        case gameStarted(OGSSeekGraphSocketStoreModel.GameStart)
        case deleteChallenge(OGSSeekGraphSocketStoreModel.ChallengeDelete)
    }

    weak var delegate: OGSListGamesStoreDelegate?
    var socketManager: OGSSocketManager!

    func connect()
    {
        //        let challenge = createChallengeFrom(payload: fakeData1())
        //        delegate?.listChallenges([challenge])

        socketManager.on(event: .seekGraphGlobal)
        { array in
            self.modelType(data: array)
        }

        socketManager.emit(event: .seekGraphConnect, with: ["channel": "global"])
    }

    func modelType(data: [Any]) -> ModelType
    {
        return .challengeList([])
    }

    func createChallengeFrom(payload: [String: Any]) -> OGSChallenge
    {
        do
        {
            let challenge: OGSChallenge = try unbox(dictionary: payload)
            return challenge
        }
        catch _
        {
            fatalError("Unable to parse Challenge")
        }
    }
}
