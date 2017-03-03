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
        }

        struct ViewModel
        {
            enum ChallengeCellType
            {
                case owner
                case other
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
