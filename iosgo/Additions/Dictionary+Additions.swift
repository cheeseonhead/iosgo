//
// Created by Cheese Onhead on 2/24/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

extension Dictionary
{
    /// Build string representation of HTTP parameter dictionary of keys and objects
    ///
    /// This percent escapes in compliance with RFC 3986
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// :returns: String representation in the form of key1=value1&key2=value2 where the keys and values are percent escaped

    func stringFromHttpParameters() -> String
    {
        let parameterArray = self.map
        { (__val: (_, _)) -> String in let (key, value) = __val
            let percentEscapedKey = (key as! String).addingPercentEncodingForURLQueryValue()!
            let percentEscapedValue = (value as! String).addingPercentEncodingForURLQueryValue()!
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }

        return parameterArray.joined(separator: "&")
    }
}
