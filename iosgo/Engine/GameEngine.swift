//
//  GameEngine.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/26/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation

private typealias Group = [BoardPoint]

class GameEngine {

    var game: Game

    var currentMarker = 0
    var playingPlayer: PlayerType
    var board: Board
    var markGrid = [BoardPoint: Int]()
    var blackPlayerPrisoners = 0
    var whitePlayerPrisoners = 1

    required init(game: Game) {
        self.game = game
        playingPlayer = (game.gameData.initialPlayer == .black) ? .black : .white
        self.board = Board(size: BoardSize(height: game.height, width: game.width))

        for move in game.gameData.moves {
            do {
                try place(at: move, checkForKo: false, errorOnSuperKo: false, dontCheckForSuperKo: true, dontCheckForSuicide: true, isTrunkMove: true)
            } catch {
                print("Error occurred while placing: \(error)")
            }
        }
    }

    func place(at point: BoardPoint, checkForKo _: Bool = false, errorOnSuperKo _: Bool = false, dontCheckForSuperKo _: Bool = false, dontCheckForSuicide: Bool = false, isTrunkMove _: Bool = false) throws {
        guard board.size.contains(point: point) else {
            return
        }

        guard board.stone(at: point) == nil else {
            return
        }

        insertStone(for: playingPlayer, at: point)

        var suicideMove = false
        let playerGroup = getGroup(at: point, clearMarks: true)
        let opponentGroups = getConnectedGroups(to: playerGroup)

        print(suicideMove)
        print("PlayerGroup: \(playerGroup)")
        print("OpponentGroup: \(opponentGroups)")

        var piecesRemoved = 0
        for opponentGroup in opponentGroups {
            if countLiberties(group: opponentGroup) == 0 {
                piecesRemoved += captureGroup(opponentGroup)
            }
        }
        if piecesRemoved == 0, countLiberties(group: playerGroup) == 0 {
            if game.gameData.allowSelfCapture || dontCheckForSuicide {
                piecesRemoved += captureGroup(playerGroup)
                suicideMove = true
            } else {
                board.removeStone(at: point)
                throw GameError.generic(message: "Move is suicidal")
            }
        }

        playingPlayer = (playingPlayer == .black) ? .white : .black
    }
    
    func prettyPoint(_ point: BoardPoint) -> String {
        guard board.size.contains(point: point) else {
            return ""
        }
        
        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let index = alphabet.index(alphabet.startIndex, offsetBy: point.column)
        return "\(alphabet[index])" + "\(board.size.height - point.row)"
    }
}

// MARK: - Liberties
private extension GameEngine {

    func countLiberties(group: Group) -> Int {
        var count = 0

        for point in group {
            forEachNeighbor(of: point, reducer: { neighbor in
                if board.stone(at: neighbor) == nil {
                    count += 1
                }
            })
        }

        return count
    }

    func captureGroup(_ group: Group) -> Int {
        for point in group {
            guard let stone = board.stone(at: point) else {
                continue
            }

            switch stone.type {
            case .black:
                blackPlayerPrisoners += 1
            case .white:
                whitePlayerPrisoners += 1
            }

            board.removeStone(at: point)
        }

        return group.count
    }
}

// MARK: - Groups
private extension GameEngine {

    func getGroup(at point: BoardPoint, clearMarks: Bool) -> Group {
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

    func getConnectedGroups(to group: Group) -> [Group] {
        currentMarker += 1
        markGroup(group)

        var ret = [Group]()
        forEachNeighbor(of: group) { neighbor in
            guard board.stone(at: neighbor) != nil else {
                return
            }

            currentMarker += 1
            markGroup(group)

            for addedGroup in ret {
                markGroup(addedGroup)
            }

            let nextGroup = getGroup(at: neighbor, clearMarks: false)
            if nextGroup.count > 0 {
                ret.append(nextGroup)
            }
        }

        return ret
    }

    func markGroup(_ group: Group) {
        for point in group {
            markGrid[point] = currentMarker
        }
    }
}

// MARK: - State
private extension GameEngine {
    
    func getState() -> State {
        let state = State(player: playingPlayer, boardIsRepeating: boardIsRepeating, whitePrisoners: whitePlayerPrisoners, blackPrisoners: blackPlayerPrisoners, board: board)
        
        return state
    }
}

// MARK: - Helpers
private extension GameEngine {

    func insertStone(for player: PlayerType, at point: BoardPoint) {
        switch player {
        case .black:
            board.placeStone(type: .black, at: point)
        case .white:
            board.placeStone(type: .white, at: point)
        }
    }

    func forEachNeighbor(of point: BoardPoint, reducer: (BoardPoint) -> Void) {
        let pointsToCheck = [point.point(at: .above), point.point(at: .below), point.point(at: .left), point.point(at: .right)]
        for checkPoint in pointsToCheck {
            if board.size.contains(point: checkPoint) {
                reducer(checkPoint)
            }
        }
    }

    func forEachNeighbor(of group: Group, reducer: (BoardPoint) -> Void) {
        var visitedPoints = Set<BoardPoint>()
        for point in group {
            visitedPoints.insert(point)
        }

        for checkPoint in group {
            forEachNeighbor(of: checkPoint, reducer: { neighbor in
                guard !visitedPoints.contains(neighbor) else {
                    return
                }

                visitedPoints.insert(neighbor)
                reducer(neighbor)
            })
        }
    }
}
