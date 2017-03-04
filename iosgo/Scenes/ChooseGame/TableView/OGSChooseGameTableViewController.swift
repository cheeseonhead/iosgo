//
//  OGSChooseGameTableViewController.swift
//  iosgo
//
//  Created by Cheese Onhead on 3/2/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import UIKit

class OGSChooseGameTableViewController: UITableViewController
{
    typealias Challenge = OGSChooseGame.ListGames.ViewModel.Challenge

    var challengeList: [Challenge] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return challengeList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let challenge = challengeList[indexPath.row]

        switch challenge.cellType
        {
            case .owner:
                return createOwnerCell(from: challenge)
            case .other(let canAccept):
                return createOtherCell(from: challenge, canAccept: canAccept)
        }
    }
}

// MARK: - Cell Creation
fileprivate extension OGSChooseGameTableViewController
{
    func createOwnerCell(from challenge: Challenge) -> OGSChooseGameOwnerTableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OGSChooseGameOwnerTableViewCell") as! OGSChooseGameOwnerTableViewCell
        cell.userInfoLabel.text = challenge.userInfo
        cell.sizeLabel.text = challenge.sizeString
        cell.timeLabel.text = challenge.timeString

        return cell
    }

    func createOtherCell(from challenge: Challenge, canAccept: Bool) -> OGSChooseGameOtherTableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OGSChooseGameOtherTableViewCell") as! OGSChooseGameOtherTableViewCell
        cell.challengerInfoLabel.text = challenge.userInfo
        cell.sizeLabel.text = challenge.sizeString
        cell.timeLabel.text = challenge.timeString
        cell.playButton.isEnabled = canAccept

        return cell
    }
}
