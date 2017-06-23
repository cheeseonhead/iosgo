//
//  Game.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/19/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox

struct Player {}

struct Tournament {}

struct Ladder {}

struct GameData {}

struct Game {

    // MARK: - Basic
    var id: Int
    var name: String
    var creatorId: Int // creator
    var blackId: Int // black
    var whiteId: Int // white

    // MARK: - Info
    var height: Int
    var width: Int

    var rules: RuleTypes
    var ranked: Bool
    var handicap: Int
    var komi: Double?

    var started: Date
    var ended: Date?
    //    var gameData: GameData

    // MARK: - Gameplay
    var disableAnalysis: Bool

    // MARK: - Time
    var timeControl: TimeControlTypes // time_control
    var timeControlParameters: TimeControlParametersType
    //    var timePerMove: Int
    //    var pauseOnWeekends: Bool
    //
    //    // MARK: - Player
    //    var blackPlayerRank: Int
    //    var blackPlayerRating: Double
    //    var whitePlayerRank: Int
    //    var whitePlayerRating: Double
    //    var players: [PlayerType: Player] // Needs its own model
    //
    //    enum PlayerType: String, Codable {
    //        case black, white
    //    }
    //
    //    // MARK: - Tournament
    //    var tournament: Tournament?
    //    var tournamentRound: Int
    //
    //    // MARK: - Ladder
    //    var ladder: Ladder?
    //
    //    // MARK: - Result
    //    var annulled: Bool
    //    var outcome: String
    //    var blackLost: Bool
    //    var whiteLost: Bool
    //
    //    // MARK: - Server
    //    var authToken: String // auth
    //    var gameChatToken: String
    //    var mode: Mode
    //    var source: Source
    //    var releated: [String: String]
    //
    //    enum Mode: String, UnboxableEnum {
    //        case game
    //    }
    //
    //    enum Source: String, UnboxableEnum {
    //        case play
    //    }
}
