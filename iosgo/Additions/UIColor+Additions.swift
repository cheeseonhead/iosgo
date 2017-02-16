//
// Created by Cheese Onhead on 2/16/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import UIKit

extension UIColor
{
    func lighterColor() -> UIColor
    {
        var h: CGFloat = 0.0
        var s: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return UIColor.init(hue: h, saturation: s, brightness: min(b * 1.05, 1.0), alpha: a)
    }
}