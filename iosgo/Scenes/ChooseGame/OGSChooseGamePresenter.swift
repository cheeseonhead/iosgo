//
//  OGSChooseGamePresenter.swift
//  iosgo
//
//  Created by Jeffrey Wu on 2017-02-26.
//  Copyright (c) 2017 Cheeseonhead. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol OGSChooseGamePresenterInput
{
    func presentListGames(response: OGSChooseGame.ListGames.Response)
}

protocol OGSChooseGamePresenterOutput: class
{
    func displayListGames(viewModel: OGSChooseGame.ListGames.ViewModel)
}

class OGSChooseGamePresenter: OGSChooseGamePresenterInput
{
    typealias ListGames = OGSChooseGame.ListGames

    weak var output: OGSChooseGamePresenterOutput!

    func presentListGames(response: ListGames.Response)
    {
        let challengeList = self.challengeList(from: response)

        let viewModel = ListGames.ViewModel(challengeList: challengeList)

        OGSDispatcher.asyncMain
        {
            self.output.displayListGames(viewModel: viewModel)
        }
    }
}

// MARK: - Create Challenges
fileprivate extension OGSChooseGamePresenter
{
    func challengeList(from response: ListGames.Response) -> [ListGames.ViewModel.Challenge]
    {
        var viewModelChallenges: [ListGames.ViewModel.Challenge] = []

        for challenge in response.challenges
        {
            let userInfo = "\(challenge.username) [\(rankString(from: challenge.challengerRank))]"
            let sizeString = "\(challenge.size.width)x\(challenge.size.height)"
            let timeString = challengeTimeString(from: challenge.timeControlParameters)
            let cellType = challengeCellType(for: challenge, response: response)

            let viewModelChallenge = ListGames.ViewModel.Challenge(userInfo: userInfo, sizeString: sizeString, timeString: timeString, cellType: cellType)
            viewModelChallenges.append(viewModelChallenge)
        }

        return viewModelChallenges
    }

    func rankString(from rank: Int) -> String
    {
        if rank < 30 {
            return "\(30 - rank)k"
        }
        else
        {
            return "\(rank - 30)d"
        }
    }

    func challengeCellType(for challenge: OGSChallenge, response: ListGames.Response) -> ListGames.ViewModel.ChallengeCellType
    {
        if challenge.username == response.username
        {
            return .owner
        }
        else
        {
            let canAccept = (challenge.maxRank >= response.userRank && challenge.minRank <= response.userRank)

            return .other(canAccept: canAccept)
        }
    }

    typealias TimeControlParametersType = OGSChallenge.TimeControlParametersType

    func challengeTimeString(from timeType: TimeControlParametersType) -> String
    {
        switch timeType {
        case let .fischer(parameters):
            return fischerTimeString(from: parameters)
        case let .simple(parameters):
            return simpleTimeString(from: parameters)
        case let .byoyomi(parameters):
            return byoyomi(from: parameters)
        case let .canadian(parameters):
            return canadian(from: parameters)
        case let .absolute(parameters):
            return absolute(from: parameters)
        case let .none(parameters):
            return NSLocalizedString("None", comment: "")
        }
    }

    func fischerTimeString(from parameters: TimeControlParametersType.Fischer) -> String
    {
        let initialTimeString = String.dateStringFrom(seconds: parameters.initialTime)
        let incrementString = String.dateStringFrom(seconds: parameters.timeIncrement)
        let maxTimeString = String.dateStringFrom(seconds: parameters.maxTime)

        return "\(initialTimeString)+ \(incrementString) up to \(maxTimeString)"
    }

    func simpleTimeString(from parameters: TimeControlParametersType.Simple) -> String
    {
        let perMoveTimeString = String.dateStringFrom(seconds: parameters.timePerMove)

        return "\(perMoveTimeString)/move"
    }

    func byoyomi(from parameters: TimeControlParametersType.Byoyomi) -> String
    {
        let mainTimeString = String.dateStringFrom(seconds: parameters.mainTime)
        let periodTimeString = String.dateStringFrom(seconds: parameters.periodTime)

        return "\(mainTimeString)+\(parameters.periodCount)x\(periodTimeString)"
    }

    func canadian(from parameters: TimeControlParametersType.Canadian) -> String
    {
        let mainTimeString = String.dateStringFrom(seconds: parameters.mainTime)
        let periodTimeString = String.dateStringFrom(seconds: parameters.periodTime)

        return "\(mainTimeString)+ \(periodTimeString)/\(parameters.stonePerPeriod)"
    }

    func absolute(from parameters: TimeControlParametersType.Absolute) -> String
    {
        return "\(parameters.totalTime)"
    }
}
