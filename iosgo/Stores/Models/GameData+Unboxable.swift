//
//  GameData+Unboxable.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/25/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox

extension GameData: Unboxable {
    init(unboxer: Unboxer) throws {
        // MARK: - Basic
        blackId = try unboxer.unbox(key: "black_player_id")
        whiteId = try unboxer.unbox(key: "white_player_id")
        `private` = try unboxer.unbox(key: "private")
        ranked = try unboxer.unbox(key: "ranked")
        gameId = try unboxer.unbox(key: "game_id")
        players = try unboxer.unbox(key: "players")

        // MARK: - Info
        gameName = try unboxer.unbox(key: "game_name")
        height = try unboxer.unbox(key: "height")
        width = try unboxer.unbox(key: "width")
        komi = unboxer.unbox(key: "komi")
        handicap = try unboxer.unbox(key: "handicap")
        rules = try unboxer.unbox(key: "rules")
        phase = try unboxer.unbox(key: "phase")
        initialPlayer = try unboxer.unbox(key: "initial_player")

        // MARK: - Time
        let parameters = unboxer.dictionary["time_control"] as! UnboxableDictionary
        timeControl = try TimeControlParametersFormatter().conditionalUnbox(dictionary: parameters)
        //    clock = try unboxer.unbox(")Clock
        startTime = try unboxer.unbox(key: "start_time")
        pausedSince = unboxer.unbox(key: "paused_since")

        // MARK: - Gameplay
        allowKo = try unboxer.unbox(key: "allow_ko")
        allowSuperko = try unboxer.unbox(key: "allow_superko")
        originalDisableAnalysis = try unboxer.unbox(key: "original_disable_analysis")
        disableAnalysis = try unboxer.unbox(key: "disable_analysis")
        freeHandicapPlacement = try unboxer.unbox(key: "free_handicap_placement")
        allowSelfCapture = try unboxer.unbox(key: "allow_self_capture")
        strictSekiMode = try unboxer.unbox(key: "strict_seki_mode")
        opponentPlaysFirstAfterResume = try unboxer.unbox(key: "opponent_plays_first_after_resume")

        // MARK: - Game
        genericMoves = try unboxer.unbox(key: "moves")
        moves = GameData.createMoves(from: genericMoves)
        conditionalMoves = try unboxer.unbox(key: "conditional_moves")
        initialState = try unboxer.unbox(key: "initial_state")
        history = try unboxer.unbox(key: "history")

        // MARK: - Pause
        pauseControl = unboxer.unbox(key: "pause_control")

        // MARK: - Scoring
        scoreStones = try unboxer.unbox(key: "score_stones") // score_stones
        agaHandicapScoring = try unboxer.unbox(key: "aga_handicap_scoring")
        scorePasses = try unboxer.unbox(key: "score_passes")
        scoreTerritoryInSeki = try unboxer.unbox(key: "score_territory_in_seki")
        automaticStoneRemoval = try unboxer.unbox(key: "automatic_stone_removal")
        scorePrisoners = try unboxer.unbox(key: "score_prisoners")
        superkoAlgorithm = try unboxer.unbox(key: "superko_algorithm")
        whiteMustPassLast = try unboxer.unbox(key: "white_must_pass_last")
        scoreTerritory = try unboxer.unbox(key: "score_territory")

        // MARK: - Review
        reviews = unboxer.unbox(key: "reviews")

        // MARK: - Others
        metaGroups = try unboxer.unbox(key: "meta_groups")
    }
}
