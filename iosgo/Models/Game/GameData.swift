//
//  GameData.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/25/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox

struct Move {}

struct Clock {}

struct GameData {

    // MARK: - Basic
    var blackId: Int // black_player_id
    var whiteId: Int // white_player_id
    var `private`: Bool
    var ranked: Bool
    var gameId: Int
    var players: [Player: [String: Any]]

    // MARK: - Info
    var gameName: String
    var height: Int
    var width: Int
    var komi: Double?
    var handicap: Int
    var rules: RuleTypes
    var phase: Phase
    var initialPlayer: Player

    enum Phase: String, UnboxableEnum {
        case play, finished
        case stoneRemoval = "stone removal"
    }

    // MARK: - Time
    var timeControl: TimeControlParametersType
    //    var clock: Clock
    var startTime: Int
    var pausedSince: Int

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
    //    var moves: [Move]
    var conditionalMoves: [Int: [String: Any?]]
    var initialState: [Player: String]
    var history: [Any]

    enum Player: String, UnboxableKey, UnboxableEnum {
        case black, white

        static func transform(unboxedKey: String) -> Player? {
            return Player.init(rawValue: unboxedKey)
        }
    }

    // MARK: - Pause
    var pauseControl: [String: Bool]

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

    // MARK: - Others
    var metaGroups: [Any]
}
