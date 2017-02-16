//
//  OGSButton.swift
//  iosgo
//
//  Created by Jeffrey Wu on 2017-02-15.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

enum OGSButtonType
{
    case primary
}

class OGSButton: UIButton
{
    // MARK: - Views
    var indicatorView: UIActivityIndicatorView!
    
    // MARK: - States
    var highlightedBackgroundColor: UIColor?
    var normalBackgroundColor: UIColor?
    var isPending: Bool = false {
        didSet {
            isUserInteractionEnabled = !isPending
            if isPending {
                titleLabel?.layer.opacity = 0;
                indicatorView.startAnimating()
            }
            else {
                titleLabel?.layer.opacity = 1;
                indicatorView.stopAnimating()
            }
        }
    }
    
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
        self.addIndicator()
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

// MARK: - Button setup
fileprivate extension OGSButton
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
    
    func addIndicator()
    {
        indicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: .white)
        addSubview(indicatorView)
        indicatorView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        bringSubview(toFront: indicatorView)
    }
}

// MARK: - Touch Handlers
extension OGSButton
{
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