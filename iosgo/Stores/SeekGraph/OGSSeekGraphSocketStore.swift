//
// Created by Jeffrey Wu on 2017-02-27.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import UIKit
import Unbox
import Starscream

class OGSSeekGraphSocketStore {
    typealias Model = OGSSeekGraphSocketStoreModel

    enum ModelType {
        case challengeList([Model.Challenge])
        case gameStarted(Model.GameStart)
        case deleteChallenge(Model.ChallengeDelete)
        case unknown
    }

    weak var delegate: OGSListGamesStoreDelegate?
    var socketManager: SocketManager!

    func connect() {
        //        let challenge = createChallengeFrom(payload: fakeData1())
        //        delegate?.listChallenges([challenge])

        socketManager.on(event: .seekGraphGlobal) { array in
            self.process(data: array[0])
        }

        socketManager.emit(event: .seekGraphConnect, with: ["channel": "global"])
    }

    func process(data: Any) {
        let modelType = self.modelType(of: data)

        switch modelType {
        case let .challengeList(challenges):
            delegate?.add(challenges)
            break
        case let .deleteChallenge(delete):
            delegate?.delete(challengeID: delete.challengeId)
            break
        case let .gameStarted(gameStart):
            delegate?.delete(gameID: gameStart.gameId)
            break
        default:
            break
        }
    }

    func modelType(of data: Any) -> ModelType {
        if let challengeList = try? createChallengeList(from: data) {
            return .challengeList(challengeList)
        } else if let gameStart = try? createGameStart(from: data) {
            return .gameStarted(gameStart)
        } else if let challengeDelete = try? createChallengeDelete(from: data) {
            return .deleteChallenge(challengeDelete)
        }

        return .unknown
    }
}

// MARK: Create Model Methods
extension OGSSeekGraphSocketStore {
    func createChallengeList(from data: Any) throws -> [Model.Challenge] {
        guard let array = data as? [Any] else {
            fatalError("List could not be created")
        }

        var challengeList: [Model.Challenge] = []

        for item in array {
            let dictionary = item as! [String: Any]
            let challenge: Model.Challenge = try createChallenge(from: dictionary)

            challengeList.append(challenge)
        }

        return challengeList
    }

    func createGameStart(from data: Any) throws -> Model.GameStart {
        guard let array = data as? [Any],
            let dictionary = array[0] as? [String: Any] else {
            fatalError("Object could not be created")
        }

        let gameStart: Model.GameStart = try unbox(dictionary: dictionary)
        return gameStart
    }

    func createChallengeDelete(from data: Any) throws -> Model.ChallengeDelete {
        guard let array = data as? [Any],
            let dictionary = array[0] as? [String: Any] else {
            fatalError("Object could not be created")
        }

        let challengeDelete: Model.ChallengeDelete = try unbox(dictionary: dictionary)
        return challengeDelete
    }

    func createChallenge(from payload: [String: Any]) throws -> Model.Challenge {
        let challenge: OGSChallenge = try unbox(dictionary: payload)
        return challenge
    }
}
