//
//  OGSChooseGameModels.swift
//  iosgo
//
//  Created by Jeffrey Wu on 2017-02-26.
//  Copyright (c) 2017 Cheeseonhead. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

struct OGSChooseGame {
    struct ListGames {
        struct Request {
        }

        struct Response {
            var loggedIn: Bool
            var username: String
            var userRank: Int
            var challenges: [OGSChallenge]
        }

        struct ViewModel {
            struct Challenge {
                var userInfo: String
                var sizeString: String
                var timeString: String
                var buttonType: ButtonType

                enum ButtonType {
                    case play
                    case cantPlay
                    case remove
                }
            }

            var challengeList: [Challenge]
        }
    }

    struct TouchGame {
        enum TouchGameError: Error {
            case challengeMissing
        }

        struct Request {
            var indexPath: IndexPath
            var action: ActionType
        }

        struct Response {
            var action: ActionType
        }

        struct ViewModel {
            var nextAction: NextAction

            enum NextAction {
                case navigate
                case alert(message: String)
            }
        }

        enum ActionType {
            case accept
            case remove
        }
    }
}
