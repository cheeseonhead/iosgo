/**
 *  Unbox
 *  Copyright (c) 2015-2017 John Sundell
 *  Licensed under the MIT license, see LICENSE file
 */

import Foundation

internal extension Sequence {
    func map<T>(allowInvalidElements: Bool, transform: (Iterator.Element) throws -> T) throws -> [T] {
        if !allowInvalidElements {
            return try map(transform)
        }

        return compactMap {
            try? transform($0)
        }
    }
}
