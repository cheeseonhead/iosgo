//
//  GameData+Codable.swift
//  iosgo
//
//  Created by Cheese Onhead on 2018-04-22.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation

extension GameData {
    enum CodingKeys: String, CodingKey {
        case scoreStones = "score_stones"
        case originalDisableAnalysis = "original_disable_analysis"
        case scoreHandicap = "score_handicap"
        case allowKo = "allow_ko"
        case `private` = "private"
        case height
        case timeControl = "time_control"
        case freeHandicapPlacement = "free_handicap_placement"
        case agaHandicapScoring = "aga_handicap_scoring"
        case genericMoves = "moves"
        case allowSuperko = "allow_superko"
        case scorePasses = "score_passes"
                case clock
        case blackPlayerId = "black_player_id"
        case pauseOnWeekends = "pause_on_weekends"
        case whitePlayerId = "white_player_id"
        case width
        //        case initialState = "initial_state"
        case scoreTerritoryInSeki = "score_territory_in_seki"
        case automaticStoneRemoval = "automatic_stone_removal"
        case handicap
        case startTime = "start_time"
        case scorePrisoners = "score_prisoners"
        case disableAnalysis = "disable_analysis"
        case allowSelfCapture = "allow_self_capture"
        case ranked
        case komi
        case gameId = "game_id"
        case strictSekiMode = "strict_seki_mode"
        case opponentPlaysFirstAfterResume = "opponent_plays_first_after_resume"
        case superkoAlgorithm = "superko_algorithm"
        case whiteMustPassLast = "white_must_pass_last"
        case rules
        case reviews
        case players
        case phase
        case gameName = "game_name"
        case scoreTerritory = "score_territory"
        case initialPlayer = "initial_player"
        //        case history = "history"
    }
}
