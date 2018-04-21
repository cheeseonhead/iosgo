//
//  PlayModels.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/25/17.
//  Copyright (c) 2017 Cheeseonhead. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum Play {
    enum LoadGame {
        struct Request {
        }

        struct Response {
            var state: GoState
        }

        struct ViewModel {
            var state: GridState
        }
    }

    enum UpdateGame {
        struct Response {
            var state: GoState
        }

        struct ViewModel {
            var state: GridState
        }
    }

    enum SubmitMove {
        struct Request {
            var move: GridPoint
        }
    }

    enum UpdateGameInfo {
        struct Response {
            struct GameInfo {
                let thinkTime: Double
                let captures: Int
            }

            let black: GameInfo
            let white: GameInfo
        }

        struct ViewModel {
            let gameInfoViewModel: GameInfoViewModel.Game
        }
    }
}
