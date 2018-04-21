//
//  PlayerInfoView.swift
//  iosgo
//
//  Created by Jeffrey Wu on 2018-04-19.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation
import UIKit

struct PlayerInfoViewModel {
    let profile: UIImage?
    let timeStr: String
    let username: String?
    let captures: String
    let color: PlayerType
}

class PlayerInfoView: UIView {
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var capturesLabel: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupFromIBDesignable()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromIBDesignable()
    }

    func setModel(_ model: PlayerInfoViewModel) {
        if let v = model.profile {
            profileImage.image = v
        }
        timeLabel.text = model.timeStr
        if let v = model.username {
            usernameLabel.text = v
        }
        capturesLabel.text = model.captures
    }
}
