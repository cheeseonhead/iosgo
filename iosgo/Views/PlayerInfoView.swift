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
    struct User {
        let color: PlayerType
        let username: String
        let profile: UIImage
    }
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

    func setTime(_ time: String) {
        timeLabel.text = time
    }

    func setUser(_ model: PlayerInfoViewModel.User) {
        profileImage.image = model.profile
        usernameLabel.text = model.username
    }
}
