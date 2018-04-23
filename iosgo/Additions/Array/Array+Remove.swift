//
//  Array+Remove.swift
//  iosgo
//
//  Created by Cheese Onhead on 2018-04-23.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation

extension Array {
    mutating func remove(where predicate: (Element) throws -> Bool) throws {
        guard let idx = try index(where: predicate) else {
            return
        }
        remove(at: idx)
    }
}
