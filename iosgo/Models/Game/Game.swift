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

struct Game {

    // MARK: - Basic
    var id: Int

    // MARK: - Info
    var height: Int
    var width: Int

    // MARK: - Data
    var gameData: GameData

    var moves: [BoardPoint] {
        return gameData.moves
    }
}
