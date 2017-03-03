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
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OGSChooseGameTableViewCell") as? OGSChooseGameOtherTableViewCell
                else { fatalError() }
        cell.challengerInfoLabel.text = "studjeff [20k]"
        cell.sizeLabel.text = "19x19"
        cell.timeLabel.text = "3d + 1d up to 1wk"

        return cell
    }
}
