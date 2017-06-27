//
//  GameEngine.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/26/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class GameEngine {

    var currentMarker = 0

    var playingPlayer: PlayerType
    var board: Board
    var markGrid = [BoardPoint: Int]()

    required init(game: Game) {
        playingPlayer = (game.gameData.initialPlayer == .black) ? .black : .white
        self.board = Board(size: BoardSize(rows: game.height, columns: game.width))
    }

    func place(at point: BoardPoint, checkForKo _: Bool = false, errorOnSuperKo _: Bool = false, dontCheckForSuperKo _: Bool = false, dontCheckForSuicide _: Bool = false, isTrunkMove _: Bool = false) throws {
        guard board.size.contains(point: point) else {
            return
        }

        guard board.stone(at: point) != nil else {
            return
        }

        insertStone(for: playingPlayer, at: point)

        let suicideMove = false
        let playerGroup = getGroup(at: point, clearMarks: true)

        print(suicideMove)
        print(playerGroup)
    }
}

// MARK: - Groups
extension GameEngine {

    func getGroup(at point: BoardPoint, clearMarks: Bool) -> [BoardPoint] {
        let targetStoneType = board.stone(at: point)?.type

        if clearMarks {
            currentMarker += 1
        }

        var pointsToCheck = [point]
        var ret = [BoardPoint]()

        while pointsToCheck.count > 0 {
            let checkPoint = pointsToCheck.remove(at: 0)

            if markGrid[checkPoint] == currentMarker {
                continue
            } else {
                markGrid[checkPoint] = currentMarker
            }

            if board.stone(at: checkPoint)?.type == targetStoneType {
                ret.append(checkPoint)
                forEachNeighbor(of: checkPoint, reducer: { nextPoint in
                    pointsToCheck.append(nextPoint)
                })
            }
        }

        return ret
    }

    func forEachNeighbor(of point: BoardPoint, reducer: (BoardPoint) -> Void) {
        let pointsToCheck = [point.point(at: .above), point.point(at: .below), point.point(at: .left), point.point(at: .right)]
        for checkPoint in pointsToCheck {
            if board.size.contains(point: checkPoint) {
                reducer(checkPoint)
            }
        }
    }
}

// MARK: - Helpers
extension GameEngine {

    func insertStone(for player: PlayerType, at point: BoardPoint) {
        switch player {
        case .black:
            board.placeStone(type: .black, at: point)
        case .white:
            board.placeStone(type: .white, at: point)
        }
    }
}
