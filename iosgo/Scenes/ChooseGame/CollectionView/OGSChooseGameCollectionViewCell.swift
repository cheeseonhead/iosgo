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
            button.setTitle(NSLocalizedString("Play", comment: ""), for: UIControlState.normal)
            button.customState = .normal
        case .cantPlay:
            button.setTitle(NSLocalizedString("Can't Accept", comment: ""), for: UIControlState.disabled)
            button.customState = .disabled
        case .remove:
            button.setTitle(NSLocalizedString("Remove", comment: ""), for: UIControlState.normal)
            button.customState = .normal
        }
    }
}
