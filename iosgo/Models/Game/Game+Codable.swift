//
//  Game+Codable.swift
//  iosgo
//
//  Created by Cheese Onhead on 2018-04-21.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation

extension Double {
    init(str: String) throws {
        guard let test = Double(str) else {
            throw ParseError.typeMismatch(expected: Double.self, actual: String.self)
        }

        self = test
    }
}

extension Game: Decodable {
    enum CodingKeys: String, CodingKey {
        case annulled
        case auth
        case black
        case blackLost = "black_lost"
        case blackPlayerRank = "black_player_rank"
        case blackPlayerRating = "black_player_rating"
        case creator
        case disableAnalysis = "disable_analysis"
        case ended
        case gameChatAuth = "game_chat_auth"
        case gamedata
        case handicap
        case height
        case historicalRatings = "historical_ratings"
        case id
        case komi
        case ladder
        case mode
        case name
        case outcome
        case pauseOnWeekends = "pause_on_weekends"
        case players
        case ranked
        case related
        case rules
        case source
        case started
        case timeControl = "time_control"
        case timeControlParameters = "time_control_parameters"
        case timePerMove = "time_per_move"
        case tournament
        case tournamentRound = "tournament_round"
        case white
        case whiteLost = "white_lost"
        case whitePlayerRank = "white_player_rank"
        case whitePlayerRating = "white_player_rating"
        case width
    }

    init(from decoder: Decoder) throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"

        let c = try decoder.container(keyedBy: Game.CodingKeys.self)
        annulled = try c.decode(.annulled)
        auth = try c.decode(.auth)
        black = try c.decode(.black)
        blackLost = try c.decode(.blackLost)
        blackPlayerRank = try c.decode(.blackPlayerRank)
        blackPlayerRating = try Double(str: try c.decode(.blackPlayerRating) as String)
        creator = try c.decode(.creator)
        disableAnalysis = try c.decode(.disableAnalysis)
        ended = nil
        if let str: String = try c.decodeIfPresent(.ended) {
            guard let date = dateFormatter.date(from: str) else {
                throw ParseError.wrongDateFormat(dateStr: str, format: dateFormatter.dateFormat)
            }
            ended = date
        }
        gameChatAuth = try c.decodeIfPresent(.gameChatAuth)
        gamedata = try c.decode(.gamedata)
        handicap = try c.decode(.handicap)
        height = try c.decode(.height)
        historicalRatings = try c.decode(.historicalRatings)
        id = try c.decode(.id)
        komi = try c.decode(.komi)
        ladder = try c.decodeIfPresent(.ladder)
        mode = try c.decode(.mode)
        name = try c.decode(.name)
        outcome = try c.decode(.outcome)
        pauseOnWeekends = try c.decode(.pauseOnWeekends)
        // Players
        ranked = try c.decode(.ranked)
        related = try c.decode(.related)
        rules = try c.decode(.rules)
        source = try c.decode(.source)
        let str: String = try c.decode(.started)
        guard let date = dateFormatter.date(from: str) else {
            throw ParseError.wrongDateFormat(dateStr: str, format: dateFormatter.dateFormat)
        }
        started = date
        timeControl = try c.decode(.timeControl)
        timeControlParameters = try c.decode(.timeControlParameters)
        timePerMove = try c.decode(.timePerMove)
        tournament = try c.decodeIfPresent(.tournament)
        tournamentRound = try c.decode(.tournamentRound)
        white = try c.decode(.white)
        whiteLost = try c.decode(.whiteLost)
        whitePlayerRank = try c.decode(.whitePlayerRank)
        whitePlayerRating = try Double(str: try c.decode(.whitePlayerRating))
        width = try c.decode(.width)
    }
}
