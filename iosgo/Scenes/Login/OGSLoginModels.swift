//
//  OGSLoginModels.swift
//  iosgo
//
//  Created by Jeffrey Wu on 2017-02-15.
//  Copyright (c) 2017 Cheeseonhead. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

struct OGSLogin
{
    struct Login
    {
        struct Request
        {
            var username: String
            var password: String
        }

        struct Response
        {
            enum LoadingStatus
            {
                case loading, success
                case error(ErrorType)
            }

            enum ErrorType: String
            {
                case networkError = "An error has occurred because of the network"
                case usernameNotFound = "Username not found"
                case incorrectPassword = "Password incorrect"
            }

            var loadingStatus: LoadingStatus
        }

        struct ViewModel
        {
            enum UserInputState
            {
                case ready
                case pending
            }

            enum ErrorLabelState
            {
                case hidden
                case showing(message: String)
            }

            var readyToNavigate: Bool
            var userInputState: UserInputState

            var errorLabelState: ErrorLabelState
        }
    }
}
