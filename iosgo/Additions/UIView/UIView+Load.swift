//
//  UIView+Load.swift
//  iosgo
//
//  Created by Jeffrey Wu on 2018-04-19.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setupFromIBDesignable() {
        let contentView = loadViewFromNib()

        addSubview(contentView)

        contentView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }

    func loadViewFromNib() -> UIView {
//        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView

        return view
    }
}
