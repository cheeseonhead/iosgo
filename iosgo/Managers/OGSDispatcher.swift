//
// Created by Cheese Onhead on 2/24/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Dispatch

class OGSDispatcher
{
    static func asyncMain(_ closure: @escaping () -> Void)
    {
        DispatchQueue.main.async
        {
            closure()
        }
    }
}
