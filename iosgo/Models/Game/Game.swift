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

struct Tournament: Codable {}

struct Ladder: Codable {}

struct HistoricalRatings: Codable {}

struct Game {

    // MARK: - Basic
    var id: Int
    var name: String
    var creator: Int // creator id
    var black: Int // black id
    var white: Int // white

    // MARK: - Info
    var height: Int
    var width: Int

    var rules: RuleType
    var ranked: Bool
    var handicap: Int
    var komi: Double

    var started: Date
    var ended: Date?
    var gamedata: GameData

    // MARK: - Gameplay
    var disableAnalysis: Bool

    // MARK: - Time
    var timeControl: TimeControlType // time_control
    var timeControlParameters: TimeControlParametersType
    var timePerMove: Double
    var pauseOnWeekends: Bool

    // MARK: - Player
    var blackPlayerRank: Int
    var blackPlayerRating: Double
    var whitePlayerRank: Int
    var whitePlayerRating: Double
    var historicalRatings: HistoricalRatings
    // "players"

    // MARK: - Ladder
    var ladder: Ladder?

    // MARK: - Tournament
    let tournament: Tournament?
    let tournamentRound: Int

    // MARK: - Result
    var annulled: Bool
    var outcome: String
    var blackLost: Bool
    var whiteLost: Bool
    //
    // MARK: - Server
    var auth: String? // auth
    var gameChatAuth: String? // game chat auth
    var mode: Mode
    var source: Source
    var related: [String: String]

    enum Mode: String, Codable {
        case game
    }

    enum Source: String, Codable {
        case play
    }

    // MARK: - Derived
    var moves: [BoardPoint] {
        return gamedata.moves
    }
}

private extension Game {
    func parseDate(_ str: String) throws -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"

        guard let res = dateFormatter.date(from: str) else {
            throw ParseError.wrongDateFormat(dateStr: started, format: dateFormatter.dateFormat)
        }
        return res
    }
}
