//
// Created by Cheese Onhead on 2/24/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

fileprivate let secondsInWeek = 604800
fileprivate let secondsInDay = 86400
fileprivate let secondsInHour = 3600
fileprivate let secondsInMinute = 60

extension String
{
    /// Percent escapes values to be added to a URL query as specified in RFC 3986
    ///
    /// This percent-escapes all characters besides the alphanumeric character set and "-", ".", "_", and "~".
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// :returns: Returns percent-escaped string.

    func addingPercentEncodingForURLQueryValue() -> String? {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")

        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }

    static func dateStringFrom(seconds: Int) -> String
    {
        var dateString = ""
        var secondsLeft = seconds

        let numberOfWeeks = secondsLeft / secondsInWeek
        if numberOfWeeks > 0 {
            dateString.append("\(numberOfWeeks)wk ")
        }
        secondsLeft %= secondsInWeek

        let numberOfDays = secondsLeft / secondsInDay
        if numberOfDays > 0 {
            dateString.append("\(numberOfDays)d ")
        }
        secondsLeft %= secondsInDay

        let numberOfHours = secondsLeft / secondsInHour
        if numberOfHours > 0 {
            dateString.append("\(numberOfHours)hr ")
        }
        secondsLeft %= secondsInHour

        let numberOfMinutes = secondsLeft / secondsInMinute
        if numberOfMinutes > 0 {
            dateString.append("\(numberOfMinutes)hr ")
        }
        secondsLeft %= secondsInMinute

        if secondsLeft > 0 {
            dateString.append("\(secondsLeft)s")
        }

        dateString = dateString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        return dateString
    }
}