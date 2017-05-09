//
//  OGSChooseGameCollectionViewCell.swift
//  iosgo
//
//  Created by Jeffrey Wu on 2017-04-10.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import UIKit

class OGSChooseGameCollectionViewCell: UICollectionViewCell
{
    enum ButtonType
    {
        case play
        case cantPlay
        case remove
    }

    @IBOutlet weak var userInfoLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var button: OGSButton! {
        didSet
        {
            button.setupAsButtonType(.primary)
        }
    }

    var buttonType: ButtonType = .play
    {
        didSet
        {
            updateButton(type: buttonType)
        }
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes
    {
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        return layoutAttributes
    }

    func updateButton(type: ButtonType)
    {
        switch type {
        case .play:
            button.backgroundColor = #colorLiteral(red: 0.4431372549, green: 0.5254901961, blue: 0.7803921569, alpha: 1)
            button.setTitle(NSLocalizedString("Play", comment: ""), for: UIControlState.normal)
            button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: UIControlState.normal)
        case .cantPlay:
            button.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9568627451, blue: 0.9882352941, alpha: 1)
            button.setTitle(NSLocalizedString("Can't Accept", comment: ""), for: UIControlState.normal)
            button.setTitleColor(#colorLiteral(red: 0.6666666667, green: 0.7098039216, blue: 0.8274509804, alpha: 1), for: UIControlState.normal)
        case .remove:
            button.backgroundColor = #colorLiteral(red: 0.4431372549, green: 0.5254901961, blue: 0.7803921569, alpha: 1)
            button.setTitle(NSLocalizedString("Remove", comment: ""), for: UIControlState.normal)
            button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: UIControlState.normal)
        }
    }
}
