//
//  Game.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/19/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox

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
    var players: [PlayerType: Player]

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
}

extension Game {
    struct Player: Codable {
        //        var agaValid:
        var country: String
        var icon: String
        var id: Int
        var professional: Bool
        var ranking: Int
        var rankingBlitz: Int
        var rankingCorrespondence: Int
        var rankingLive: Int
        var rating: Double
        var ratingBlitz: Double
        var ratingCorrespondence: Double
        var ratingLive: Double
        //        var ratings:
        //        var uiClass: String
        var username: String

        enum CodingKeys: String, CodingKey {
            //            case agaValid = "aga_valid"
            case country
            case icon
            case id
            case professional
            case ranking
            case rankingBlitz = "ranking_blitz"
            case rankingCorrespondence = "ranking_correspondence"
            case rankingLive = "ranking_live"
            case rating
            case ratingBlitz = "rating_blitz"
            case ratingCorrespondence = "rating_correspondence"
            case ratingLive = "rating_live"
            //            case ratings
            //            case uiClass = "ui_class"
            case username
        }
    }
}
