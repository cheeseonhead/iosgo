//
//  Alertable.swift
//  iosgo
//
//  Created by Cheese Onhead on 2018-04-23.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation
import UIKit

protocol Alerting {
    func errorAlert(_ error: Error)
}

extension Alerting where Self: UIViewController {
    func errorAlert(_ error: Error) {
        let controller = UIAlertController.simpleAlert(title: String(describing: type(of: error)), message: error.localizedDescription, actionText: NSLocalizedString("Ok", comment: ""))
        present(controller, animated: true, completion: nil)
    }
}
