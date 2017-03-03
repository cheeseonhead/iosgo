//
// Created by Cheese Onhead on 3/2/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import UIKit

class OGSChooseGameOwnerTableViewCell: UITableViewCell
{
    @IBOutlet weak var userInfoLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var removeButton: OGSButton! {
        didSet {
            removeButton.setupAsButtonType(.primary)
        }
    }

}
