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

        button.setRoundCorner()
        button.addShadow()
    }
}

fileprivate extension UIButton
{
    func setRoundCorner()
    {
        self.layer.cornerRadius = 3
    }

    func addShadow()
    {
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowColor = UIColor.init(white: 0.1, alpha: 1.0).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 0.2
    }
}
