//
//  UIAlertController+Make.swift
//  iosgo
//
//  Created by Cheese Onhead on 2018-04-23.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    /// Create alert with only one button that cancels the alert
    static func simpleAlert(title: String?, message: String?, actionText: String?) -> UIAlertController {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionText, style: .cancel, handler: nil)

        controller.addAction(action)

        return controller
    }
}
