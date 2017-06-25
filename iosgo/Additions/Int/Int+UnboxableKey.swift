//
//  Int+UnboxableKey.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/25/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox

extension Int: UnboxableKey {
    public static func transform(unboxedKey: String) -> Int? {
        return Int(unboxedKey)
    }
}
