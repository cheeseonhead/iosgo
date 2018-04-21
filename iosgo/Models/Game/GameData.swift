//
//  GameData.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/25/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox

struct GameData {

    // MARK: - Basic

    var blackId: Int // black_player_id
    var whiteId: Int // white_player_id
    var `private`: Bool
    var ranked: Bool
    var gameId: Int
    var players: [PlayerType: [String: Any]]

    // MARK: - Info

    var gameName: String
    var height: Int
    var width: Int
    var komi: Double?
    var handicap: Int
    var rules: RuleType
    var phase: Phase
    var initialPlayer: PlayerType

    enum Phase: String, UnboxableEnum {
        case play, finished
        case stoneRemoval = "stone removal"
    }

    // MARK: - Time

    var timeControl: TimeControlParametersType
    //    var clock: Clock
    var startTime: Int
    var pausedSince: Int?

    // MARK: - Gameplay

    var allowKo: Bool
    var allowSuperko: Bool
    var originalDisableAnalysis: Bool
    var disableAnalysis: Bool
    var freeHandicapPlacement: Bool
    var allowSelfCapture: Bool
    var strictSekiMode: Bool
    var opponentPlaysFirstAfterResume: Bool

    // MARK: - Game

    var genericMoves: [[Int]]
    var conditionalMoves: [Int: [String: Any?]]?
    var initialState: [PlayerType: String]
    var history: [Any]

    // MARK: - Pause

    var pauseControl: [String: Bool]?

    // MARK: - Scoring

    var scoreStones: Bool // score_stones
    var agaHandicapScoring: Bool
    var scorePasses: Bool
    var scoreTerritoryInSeki: Bool
    var automaticStoneRemoval: Bool
    var scorePrisoners: Bool
    var superkoAlgorithm: String
    var whiteMustPassLast: Bool
    var scoreTerritory: Bool

    // MARK: - Review

    var reviews: [String: Any]?

    // MARK: - Derived

    var moves: [BoardPoint]
}

extension GameData {
    static func createMoves(from genericMoves: [[Int]]) -> [BoardPoint] {
        var moves = [BoardPoint]()

        for genericMove in genericMoves {
            let col = genericMove[0]
            let row = genericMove[1]
            let move = BoardPoint(row: row, column: col)
            moves.append(move)
        }

        return moves
    }
}
