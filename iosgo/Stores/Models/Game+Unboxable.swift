//
//  GameStoreModels.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/21/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox

extension Game: Unboxable {

    init(unboxer: Unboxer) throws {
        id = try unboxer.unbox(key: "id")
        name = try unboxer.unbox(key: "name")
        creatorId = try unboxer.unbox(key: "creator")
        blackId = try unboxer.unbox(key: "black")
        whiteId = try unboxer.unbox(key: "white")

        height = try unboxer.unbox(key: "height")
        width = try unboxer.unbox(key: "width")

        rules = try unboxer.unbox(key: "rules")
        ranked = try unboxer.unbox(key: "ranked")
        handicap = try unboxer.unbox(key: "handicap")
        komi = unboxer.unbox(key: "komi")

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        started = try unboxer.unbox(key: "started", formatter: dateFormatter)
        ended = unboxer.unbox(key: "ended", formatter: dateFormatter)
        //        gameData = try unboxer.unbox(key: "gameData")

        disableAnalysis = try unboxer.unbox(key: "disable_analysis")

        timeControl = try unboxer.unbox(key: "time_control")
        let parametersFormatter = TimeControlParametersFormatter()
        timeControlParameters = try unboxer.unbox(key: "time_control_parameters", formatter: parametersFormatter)

        //        // MARK: - Time
        //        var timePerMove: Int
        //        var pauseOnWeekends: Bool
        //
        //        // MARK: - Player
        //        var blackPlayerRank: Int
        //        var blackPlayerRating: Double
        //        var whitePlayerRank: Int
        //        var whitePlayerRating: Double
        //        var players: [PlayerType: Player] // Needs its own model
        //
        //        enum PlayerType: String, Codable {
        //            case black, white
        //        }
        //
        //        // MARK: - Tournament
        //        var tournament: Tournament?
        //        var tournamentRound: Int
        //
        //        // MARK: - Ladder
        //        var ladder: Ladder?
        //
        //        // MARK: - Result
        //        var annulled: Bool
        //        var outcome: String
        //        var blackLost: Bool
        //        var whiteLost: Bool
        //
        //        // MARK: - Server
        //        var authToken: String // auth
        //        var gameChatToken: String
        //        var mode: Mode
        //        var source: Source
        //        var releated: [String: String]
    }
}
