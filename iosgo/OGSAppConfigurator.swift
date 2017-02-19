//
// Created by Jeffrey Wu on 2017-02-18.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class OGSAppConfigurator
{
    var domainName = "https://beta.online-go.com/"

    func configureApp()
    {
        OGSApiManager.sharedInstance.domainName = domainName
    }
}
