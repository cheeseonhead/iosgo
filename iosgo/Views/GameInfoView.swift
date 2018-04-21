//
//  GameInfoViewController.swift
//  iosgo
//
//  Created by Jeffrey Wu on 2018-04-19.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

struct GameInfoViewModel {
}

class GameInfoView: UIView {
    @IBOutlet var topInfoView: PlayerInfoView!
    @IBOutlet var bottomInfoView: PlayerInfoView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupFromIBDesignable()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromIBDesignable()
    }

    func setClocks(blackTime: String, whiteTime: String) {
        topInfoView.setTime(blackTime)
        bottomInfoView.setTime(whiteTime)
    }
}
