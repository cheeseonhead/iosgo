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

        // MARK: - Basic
        id = try unboxer.unbox(key: "id")
        name = try unboxer.unbox(key: "name")
        creatorId = try unboxer.unbox(key: "creator")
        blackId = try unboxer.unbox(key: "black")
        whiteId = try unboxer.unbox(key: "white")

        // MARK: - Info
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
        gameData = try unboxer.unbox(key: "gamedata")

        // MARK: - Gameplay
        disableAnalysis = try unboxer.unbox(key: "disable_analysis")

        // MARK: - Time
        timeControl = try unboxer.unbox(key: "time_control")
        let parametersFormatter = TimeControlParametersFormatter()
        timeControlParameters = try unboxer.unbox(key: "time_control_parameters", formatter: parametersFormatter)
        timePerMove = try unboxer.unbox(key: "time_per_move")
        pauseOnWeekends = try unboxer.unbox(key: "pause_on_weekends")

        // MARK: - Player
        blackPlayerRank = try unboxer.unbox(key: "black_player_rank")
        blackPlayerRating = try unboxer.unbox(key: "black_player_rating")
        whitePlayerRank = try unboxer.unbox(key: "white_player_rank")
        whitePlayerRating = try unboxer.unbox(key: "white_player_rating")
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
        // MARK: - Result
        annulled = try unboxer.unbox(key: "annulled")
        outcome = try unboxer.unbox(key: "outcome")
        blackLost = try unboxer.unbox(key: "black_lost")
        whiteLost = try unboxer.unbox(key: "white_lost")

        // MARK: - Server
        authToken = unboxer.unbox(key: "auth") // auth
        gameChatToken = unboxer.unbox(key: "game_chat_auth")
        //                 mode: Mode
        //                 source: Source
        related = try unboxer.unbox(key: "related")
    }
}
