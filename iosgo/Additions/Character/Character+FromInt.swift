//
//  Character+FromInt.swift
//  iosgo
//
//  Created by Jeffrey Wu on 2018-04-12.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation

extension Character {
    /// Matches 0 to A, 1 to B ... 25 to Z
    public static func fromInt(_ n: Int) -> Character {
        assert(n < 26 && n >= 0)
        let startingValue = Int(("A" as UnicodeScalar).value)

        return Character(UnicodeScalar(n + startingValue)!)
    }
}
