//
// Created by Jeffrey Wu on 2017-02-26.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class OGSUserSettings: NSObject, OGSUserSettingsProtocol
{
    static var DataName: String = "UserSetting"
    static var DataVersion: Int = 2

    var accessToken: String?
    var refreshToken: String?

    required convenience init?(coder aDecoder: NSCoder)
    {
        self.init()
        accessToken = aDecoder.decodeObject(forKey: "accessToken") as? String
        refreshToken = aDecoder.decodeObject(forKey: "refreshToken") as? String
    }

    public func encode(with aCoder: NSCoder)
    {
        aCoder.encode(accessToken, forKey: "accessToken")
        aCoder.encode(refreshToken, forKey: "refreshToken")
    }
}
