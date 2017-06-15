//
//  CGSize+Scalable.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/15/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import UIKit

extension CGSize {

    func scaled(by ratio: CGFloat) -> CGSize {
        return scaled(using: CGVector(dx: ratio, dy: ratio))
    }

    func scaled(using vector: CGVector) -> CGSize {
        return CGSize(width: width * vector.dx, height: height * vector.dy)
    }
}
