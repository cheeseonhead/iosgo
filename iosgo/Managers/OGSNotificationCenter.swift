//
// Created by Jeffrey Wu on 2017-02-22.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class OGSNotificationCenter
{
    enum NotificationName: String
    {
        case accessTokenUpdated
        case refreshTokenUpdated
    }

    static var sharedInstance = OGSNotificationCenter()

    private var notificationCenter = NotificationCenter()

    func addObserver(_ observer: Any, selector: Selector, name: NotificationName, object: Any?)
    {
        let notificationName = Notification.Name(name.rawValue)
        notificationCenter.addObserver(observer, selector: selector, name: notificationName, object: object)
    }

    func post(name: NotificationName, object: Any?)
    {
        let notificationName = Notification.Name(name.rawValue)
        notificationCenter.post(name: notificationName, object: object)
    }
}
