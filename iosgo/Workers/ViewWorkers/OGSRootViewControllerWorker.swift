//
// Created by Cheese Onhead on 5/27/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import UIKit

class OGSRootViewControllerWorker
{
    func rootViewController(for session: OGSSession) -> UIViewController
    {
        var vc: UIViewController
        if session.tokensExists
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            vc = storyboard.instantiateViewController(withIdentifier: "MainTabBar")
        }
        else
        {
            let storyboard = UIStoryboard(name: "OGSLoginViewController", bundle: nil)
            vc = storyboard.instantiateInitialViewController()!
        }
        return vc
    }
}
