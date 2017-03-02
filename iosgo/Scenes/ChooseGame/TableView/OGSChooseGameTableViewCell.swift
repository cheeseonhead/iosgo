//
// Created by Cheese Onhead on 3/2/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import UIKit

class OGSChooseGameTableViewCell: UITableViewCell
{
    @IBOutlet weak var challengerInfoLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var playButton: OGSButton!
    {
        didSet {
            playButton.setupAsButtonType(.primary)
        }
    }
}
