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
            let json = try JSONSerialization.jsonObject(with: data)

            print(json)
        } catch {
            print(error)
        }
        return nil
    }
}
