//
// Created by Cheese Onhead on 2/24/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class OGSDispatcher
{
    static func asyncMain(completion: @escaping ()->(Void))
    {
        DispatchQueue.main.async {
            completion()
        }
    }
}
