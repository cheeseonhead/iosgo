//
// Created by Cheese Onhead on 2/16/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Hex
// https://gist.github.com/berikv/ecf1f79c5bc9921c47ef
extension UIColor
{
    // Usage: UIColor(hex: 0xFC0ACE)
    convenience init(hex: Int) {
        self.init(hex: hex, alpha: 1)
    }

    // Usage: UIColor(hex: 0xFC0ACE, alpha: 0.25)
    convenience init(hex: Int, alpha: Double) {
        self.init(
                red: CGFloat((hex >> 16) & 0xff) / 255,
                green: CGFloat((hex >> 8) & 0xff) / 255,
                blue: CGFloat(hex & 0xff) / 255,
                alpha: CGFloat(alpha))
    }
}

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
