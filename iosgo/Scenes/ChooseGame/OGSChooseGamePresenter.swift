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
    typealias Challenge = OGSChooseGame.ListGames.ViewModel.Challenge

    weak var output: OGSChooseGamePresenterOutput!

    func presentListGames(response: OGSChooseGame.ListGames.Response)
    {
        typealias UseCase = OGSChooseGame.ListGames

        let game1 = Challenge(userInfo: "studjeff2 [20k]", sizeString: "19x19", timeString: "3d + up to 1 wk", cellType: .owner)
        let game2 = Challenge(userInfo: "timeToDie [100d]", sizeString: "13x13", timeString: "10 yrs", cellType: .other)
        let gameList = [game1, game2,game1, game2,game1, game2,game1, game2,game1, game2,game1, game2,game1, game2,game1, game2,game1, game2,game1, game2]

        let viewModel = UseCase.ViewModel(challengeList: gameList)

        output.displayListGames(viewModel: viewModel)
    }
}
    func rankString(from rank:Int) -> String
    {
        if rank < 30 {
            return "\(30 - rank)k"
        }
        else {
            return "\(rank-30)d"
        }
    }

    typealias TimeControlParameterType = ListGames.Response.TimeControlParametersType

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
        let initialTimeString = dateStringFrom(seconds: parameters.initialTime)
        let incrementString = dateStringFrom(seconds: parameters.timeIncrement)
        let maxTimeString = dateStringFrom(seconds: parameters.maxTime)

        return "\(initialTimeString)+ \(incrementString) up to \(maxTimeString)"
    }

    func simpleTimeString(from parameters: TimeControlParameterType.Simple) -> String
    {
        let perMoveTimeString = dateStringFrom(seconds: parameters.timePerMove)

        return "\(perMoveTimeString)/move"
    }

    func dateStringFrom(seconds: Int) -> String
    {
        var dateString = ""
        var secondsLeft = seconds

        let numberOfWeeks = secondsLeft / secondsInWeek
        if numberOfWeeks > 0 {
            dateString.append("\(numberOfWeeks)wk ")
        }
        secondsLeft %= secondsInWeek

        let numberOfDays = secondsLeft / secondsInDay
        if numberOfDays > 0 {
            dateString.append("\(numberOfDays)d ")
        }
        secondsLeft %= secondsInDay

        let numberOfHours = secondsLeft / secondsInHour
        if numberOfHours > 0 {
            dateString.append("\(numberOfHours)hr ")
        }
        secondsLeft %= secondsInHour

        let numberOfMinutes = secondsLeft / secondsInMinute
        if numberOfMinutes > 0 {
            dateString.append("\(numberOfMinutes)hr ")
        }
        secondsLeft %= secondsInMinute

        if secondsLeft > 0 {
            dateString.append("\(secondsLeft)s")
        }

        dateString = dateString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        return dateString
    }
