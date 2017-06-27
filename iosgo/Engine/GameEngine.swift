//
//  GameEngine.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/26/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class GameEngine {

    var size: BoardPoint

    required init(game: Game) {
        size = BoardPoint(row: game.height, column: game.width)
    }

    func place(at _: BoardPoint, checkForKo _: Bool = false, errorOnSuperKo _: Bool = false, dontCheckForSuperKo _: Bool = false, dontCheckForSuicide _: Bool = false, isTrunkMove _: Bool = false) {
    }
}
