//
//  GameStore.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/24/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox

class GameStore {

    struct Response {
        var result: Result
    }

    enum Result {
        case success(game: Game)
        case error(type: ApiErrorType)
    }

    private var apiStore: OGSApiStore

    required init(apiStore: OGSApiStore) {
        self.apiStore = apiStore
    }

    func getGame(completion: @escaping (_ response: Response) -> Void) {
        let url = "/api/v1/games/2801"

        apiStore.request(toUrl: url, method: .GET, parameters: [:]) { code, payload, _ in

            var response = Response(result: .error(type: ApiErrorType.init(statusCode: code)))

            switch code {
            case .ok:
                do {
                    let game = try self.createGame(payload: payload!)

                    response.result = .success(game: game)
                } catch {
                    print(error)
                }
            default:
                break
            }

            completion(response)
        }
    }
}

private extension GameStore {
    func createGame(payload: [String: Any]) throws -> Game {
        let game: Game = try unbox(dictionary: payload)
        return game
    }
}
