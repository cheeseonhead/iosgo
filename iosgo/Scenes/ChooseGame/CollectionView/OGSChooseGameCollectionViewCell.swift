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
    @IBOutlet weak var button: OGSButton! {
        didSet
        {
            button.setupAsButtonType(.primary)
        }
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes
    {
        return layoutAttributes
    }
}
