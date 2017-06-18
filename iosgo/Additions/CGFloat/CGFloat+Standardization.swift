//
//  CGFloat+Standardization.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/14/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import UIKit

extension CGFloat {
    func standardizeAndRound(offset: CGFloat, dividedBy deviation: CGFloat) -> Int {
        let standard = standardize(offset: offset, dividedBy: deviation)
        return Int(floor(standard + CGFloat(0.5)))
    }

    func standardize(offset: CGFloat, dividedBy deviation: CGFloat) -> CGFloat {
        return (self + offset) / deviation
    }
}
