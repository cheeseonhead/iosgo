//
//  JSONDecoder+Dictionary.swift
//  iosgo
//
//  Created by Jeffrey Wu on 2018-04-12.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]

extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, from dictionary: JSON) throws -> T {
        let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])

        return try decode(type, from: data)
    }
}
