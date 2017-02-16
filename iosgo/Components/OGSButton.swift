//
//  OGSButton.swift
//  iosgo
//
//  Created by Jeffrey Wu on 2017-02-15.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import UIKit

enum OGSButtonType
{
    case primary
}

class OGSButton: UIButton
{
    var highlightedBackgroundColor: UIColor?
    var normalBackgroundColor: UIColor?

    override var buttonType: UIButtonType
    {
        return .custom
    }

    func setupAsButtonType(_: OGSButtonType)
    {
        self.setAllBackgroundColors()
        self.addAllTouchHandlers()
        self.setRoundCorner()
        self.addShadow()
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

extension OGSButton
{
    func addAllTouchHandlers()
    {
        addTarget(self, action: #selector(self.changeToHighlightedState), for: .touchDown)
        addTarget(self, action: #selector(self.changeToNormalState), for: .touchDragExit)
        addTarget(self, action: #selector(self.changeToHighlightedState), for: .touchDragEnter)
        addTarget(self, action: #selector(self.changeToNormalState), for: .touchUpInside)
    }

    func setAllBackgroundColors()
    {
        normalBackgroundColor = self.backgroundColor
        highlightedBackgroundColor = self.backgroundColor?.lighterColor()
    }

    func setRoundCorner()
    {
        layer.cornerRadius = 3
    }

    func addShadow()
    {
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.init(white: 0.1, alpha: 1.0).cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 2
    }

    // MARK: - Touch Handlers
    func changeToHighlightedState()
    {
        UIView.animate(withDuration: 0.2)
        {
            self.backgroundColor = self.highlightedBackgroundColor
            self.layer.shadowRadius = 3
        }
    }

    func changeToNormalState()
    {
        UIView.animate(withDuration: 0.2)
        {
            self.backgroundColor = self.normalBackgroundColor
            self.layer.shadowRadius = 2
        }
    }
}
