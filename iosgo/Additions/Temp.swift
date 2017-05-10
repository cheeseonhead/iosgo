//
// Created by Jeffrey Wu on 2017-02-17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

// Remember to move anything here to appropriate files!

extension Array
{
    mutating func remove(where predicate: (Element) throws -> Bool) throws
    {
        guard let idx = try index(where: predicate) else
        {
            return
        }
        remove(at: idx)
    }
}
