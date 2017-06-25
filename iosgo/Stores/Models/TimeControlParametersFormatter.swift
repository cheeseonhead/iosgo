//
//  TimeControlParametersFormatter.swift
//  iosgo
//
//  Created by Cheese Onhead on 6/24/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation
import Unbox

class TimeControlParametersFormatter: UnboxFormatter {
    typealias UnboxRawValue = String
    typealias UnboxFormattedType = TimeControlParametersType

    func format(unboxedValue: String) -> TimeControlParametersType? {
        guard let data = unboxedValue.data(using: .utf8) else {
            return nil
        }

        do {
            let json = try JSONSerialization.jsonObject(with: data) as! UnboxableDictionary
            let unboxer = Unboxer(dictionary: json)
            let type: TimeControlTypes = try unboxer.unbox(key: "time_control")

            switch type {
            case .absolute:
                let absolute: TimeControlParametersType.Absolute = try unbox(dictionary: json)
                return .absolute(parameters: absolute)
            case .byoyomi:
                let byoyomi: TimeControlParametersType.Byoyomi = try unbox(dictionary: json)
                return .byoyomi(parameters: byoyomi)
            case .canadian:
                let canadian: TimeControlParametersType.Canadian = try unbox(dictionary: json)
                return .canadian(parameters: canadian)
            case .fischer:
                let fisher: TimeControlParametersType.Fischer = try unbox(dictionary: json)
                return .fischer(parameters: fisher)
            case .none:
                let none: TimeControlParametersType.None = try unbox(dictionary: json)
                return .none(parameters: none)
            case .simple:
                let simple: TimeControlParametersType.Simple = try unbox(dictionary: json)
                return .simple(parameters: simple)
            }
        } catch {
            print(error)
            return nil
        }
    }

    static func conditionalUnbox(dictionary: UnboxableDictionary) throws -> TimeControlParametersType {
        let data = try! JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        let str = String(data: data, encoding: .ascii)!
        let newDict = ["anything": str] as UnboxableDictionary
        let unboxer2 = Unboxer(dictionary: newDict)
        let timeControlParameters: TimeControlParametersType = try unboxer2.unbox(key: "anything", formatter: TimeControlParametersFormatter())

        return timeControlParameters
    }
}
