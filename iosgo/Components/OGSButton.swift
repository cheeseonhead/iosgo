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

enum OGSButtonState
{
    case normal
    case highlighted
    case disabled
    case pending
}

class OGSButton: UIButton
{
    // MARK: - Views
    var indicatorView: UIActivityIndicatorView!

    // MARK: - States
    var highlightedBackgroundColor: UIColor?
    var normalBackgroundColor: UIColor?
    var disabledBackgroundColor: UIColor?
    var customState: OGSButtonState = .normal
    {
        didSet
        {
            change(to: customState)
        }
    }

    override var buttonType: UIButtonType
    {
        return .custom
    }

    func setupAsButtonType(_: OGSButtonType)
    {
        self.setAllTextColors()
        self.setAllBackgroundColors()
        self.addAllTouchHandlers()
        self.setRoundCorner()
        self.addShadow()
        self.addIndicator()

        change(to: currentState())
    }
}

// MARK: - Touch Handlers
extension OGSButton
{
    func change(to state: OGSButtonState)
    {
        UIView.animate(withDuration: 0.2)
        {
            self.isEnabled = self.enabled(for: state)
            self.isUserInteractionEnabled = self.userInteractionEnabled(for: state)
            self.backgroundColor = self.backgroundColor(for: state)
            self.layer.shadowRadius = self.shadowRadius(for: state)
            self.titleLabel?.alpha = self.titleLabelOpacity(for: state)
            self.indicatorView.isHidden = self.indicatorHidden(for: state)
            if !self.indicatorView.isHidden
            {
                self.indicatorView.startAnimating()
            }
        }
    }

    func changeToNormalState()
    {
        change(to: .normal)
    }

    func changeToHighlightedState()
    {
        change(to: .highlighted)
    }

    func changeToDisabledState()
    {
        change(to: .disabled)
    }

    func changeToPendingState()
    {
        change(to: .pending)
    }

    func currentState() -> OGSButtonState
    {
        if state == UIControlState.normal
        {
            return .normal
        }
        else if state == UIControlState.disabled
        {
            return .disabled
        }
        else if state == UIControlState.highlighted
        {
            return .highlighted
        }
        else
        {
            return .pending
        }
    }
}

// MARK: - Property Changes
fileprivate extension OGSButton
{
    func enabled(for state: OGSButtonState) -> Bool
    {
        switch state {
        case .normal:
            fallthrough
        case .highlighted:
            return true
        default:
            return false
        }
    }

    func userInteractionEnabled(for state: OGSButtonState) -> Bool
    {
        switch state {
        case .normal:
            fallthrough
        case .highlighted:
            return true
        default:
            return false
        }
    }

    func backgroundColor(for state: OGSButtonState) -> UIColor?
    {
        switch state {
        case .normal:
            fallthrough
        case .pending:
            return normalBackgroundColor
        case .disabled:
            return disabledBackgroundColor
        case .highlighted:
            return highlightedBackgroundColor
        }
    }

    func shadowRadius(for state: OGSButtonState) -> CGFloat
    {
        switch state {
        case .normal:
            fallthrough
        case .pending:
            return 2
        case .disabled:
            return 0
        case .highlighted:
            return 3
        }
    }

    func titleLabelOpacity(for state: OGSButtonState) -> CGFloat
    {
        switch state {
        case .pending:
            return 0.0
        default:
            return 1.0
        }
    }

    func indicatorHidden(for state: OGSButtonState) -> Bool
    {
        switch state {
        case .pending:
            return false
        default:
            return true
        }
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

    func setAllTextColors()
    {
        setTitleColor(OGSColor.primaryTextDisabled, for: .disabled)
    }

    func setAllBackgroundColors()
    {
        normalBackgroundColor = self.backgroundColor
        highlightedBackgroundColor = self.backgroundColor?.lighterColor()
        disabledBackgroundColor = OGSColor.primaryBackgroundDisabled
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
        indicatorView.snp.makeConstraints
        { make in
            make.center.equalTo(self)
        }
        bringSubview(toFront: indicatorView)
    }
}
