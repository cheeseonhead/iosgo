//
//  UnboxFormatter+Dictionary.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/25/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox

extension UnboxFormatter {

    func conditionalUnbox(dictionary: UnboxableDictionary) throws -> UnboxFormattedType {
        let data = try! JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        let str = String(data: data, encoding: .ascii)!
        let newDict = ["anything": str] as UnboxableDictionary
        let unboxer = Unboxer(dictionary: newDict)
        let timeControlParameters: UnboxFormattedType = try unboxer.unbox(key: "anything", formatter: self)

        return timeControlParameters
    }
}
