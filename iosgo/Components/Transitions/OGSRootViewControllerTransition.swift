//
// Created by Cheese Onhead on 5/27/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import UIKit

class OGSRootViewControllerTransition
{
    var from: UIViewController
    var to: UIViewController

    required init(from: UIViewController, to: UIViewController)
    {
        self.from = from
        self.to = to
    }
}
