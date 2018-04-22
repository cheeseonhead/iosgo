//
//  KeyedDecodingContainer+Shorten.swift
//  iosgo
//
//  Created by Cheese Onhead on 2018-04-21.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation

extension KeyedDecodingContainer {
    public func decode<T: Decodable>(_ key: Key, as _: T.Type = T.self) throws -> T {
        return try decode(T.self, forKey: key)
    }

    public func decodeIfPresent<T: Decodable>(_ key: KeyedDecodingContainer.Key) throws -> T? {
        return try decodeIfPresent(T.self, forKey: key)
    }
}
