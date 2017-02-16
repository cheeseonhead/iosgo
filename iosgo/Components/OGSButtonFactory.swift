//
//  OGSButton.swift
//  iosgo
//
//  Created by Jeffrey Wu on 2017-02-15.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import UIKit

enum OGSButtonType
{
    case primary
}

class OGSButtonFactory
{
    static var sharedInstance = OGSButtonFactory()

    private init() {}
    func setupPrimaryButton(button: UIButton)
    {
        guard button.buttonType == .custom else { return }

        button.layer.cornerRadius = 3

        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowColor = UIColor.init(white: 0.8, alpha: 1.0).cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 0.2
    }
}
