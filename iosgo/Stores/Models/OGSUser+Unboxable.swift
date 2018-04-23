//
// Created by Cheese Onhead on 5/27/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox

extension User: Unboxable {
    init(unboxer: Unboxer) throws {
        username = try unboxer.unbox(key: "username")
        rank = try unboxer.unbox(key: "ranking")
        id = try unboxer.unbox(key: "id")
    }
}
