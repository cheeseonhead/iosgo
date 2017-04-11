//
// Created by Cheese Onhead on 2/16/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Custom Colors
class OGSColor: UIColor
{
    static var primaryBackground: UIColor
    {
        return #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }

    static var primaryBackgroundDisabled: UIColor
    {
        return #colorLiteral(red: 0.6666666667, green: 0.7098039216, blue: 0.8274509804, alpha: 1)
    }

    static var primaryTextDisabled: UIColor
    {
        return #colorLiteral(red: 0.6666666667, green: 0.7098039216, blue: 0.8274509804, alpha: 1)
    }
}

// MARK: - Hex
// https://gist.github.com/berikv/ecf1f79c5bc9921c47ef
extension OGSColor
{
    // Usage: UIColor(hex: 0xFC0ACE)
    convenience init(hex: Int)
    {
        self.init(hex: hex, alpha: 1)
    }

    // Usage: UIColor(hex: 0xFC0ACE, alpha: 0.25)
    convenience init(hex: Int, alpha: Double)
    {
        self.init(
            red: CGFloat((hex >> 16) & 0xFF) / 255,
            green: CGFloat((hex >> 8) & 0xFF) / 255,
            blue: CGFloat(hex & 0xFF) / 255,
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
