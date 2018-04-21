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
    struct Game {
        let black: PlayerInfoViewModel.Game
        let white: PlayerInfoViewModel.Game
    }
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

    func setGame(_ model: GameInfoViewModel.Game) {
        topInfoView.setGame(model.black)
        bottomInfoView.setGame(model.white)
    }
}
