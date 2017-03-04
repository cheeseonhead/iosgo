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

struct OGSChooseGame
{
    struct ListGames
    {
        struct Request
        {
        }
        struct Response
        {
            var username: String
            var userRank: Int
            var challenges: [Challenge]

            struct Challenge
            {
                var challengerUsername: String
                var challengerRank: Int
                var minLevel: Int
                var maxLevel: Int
                var width: Int
                var height: Int
                var timeControlParameters: TimeControlParametersType
            }

            enum TimeControlParametersType
            {
                case fischer(parameters: Fischer)
                case simple(parameters: Simple)

                struct Fischer
                {
                    var initialTime: Int
                    var maxTime: Int
                    var timeIncrement: Int
                }

                struct Simple
                {
                    var timePerMove: Int
                }
            }
        }

        struct ViewModel
        {
            enum ChallengeCellType
            {
                case owner
                case other(canAccept:Bool)
            }

            struct Challenge
            {
                var userInfo: String
                var sizeString: String
                var timeString: String
                var cellType: ChallengeCellType
            }

            var challengeList: [Challenge]
        }
    }
}
