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
        let username = response.username
        let userLevel = response.userRank

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

    typealias TimeControlParameterType = OGSChallenge.TimeControlParametersType

    func challengeTimeString(from timeType: TimeControlParameterType) -> String
    {
        switch timeType {
        case .fischer(let parameters):
            return fischerTimeString(from: parameters)
        case .simple(let parameters):
            return simpleTimeString(from: parameters)
        }
    }

    func fischerTimeString(from parameters: TimeControlParameterType.Fischer) -> String
    {
        let initialTimeString = String.dateStringFrom(seconds: parameters.initialTime)
        let incrementString = String.dateStringFrom(seconds: parameters.timeIncrement)
        let maxTimeString = String.dateStringFrom(seconds: parameters.maxTime)

        return "\(initialTimeString)+ \(incrementString) up to \(maxTimeString)"
    }

    func simpleTimeString(from parameters: TimeControlParameterType.Simple) -> String
    {
        let perMoveTimeString = String.dateStringFrom(seconds: parameters.timePerMove)

        return "\(perMoveTimeString)/move"
    }
}
