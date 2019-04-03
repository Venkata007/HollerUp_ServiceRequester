//
//  StringExtension.swift
//  QHost
//
//  Created by Admin on 29/06/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation

extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    func substring(_ from: Int) -> String {
        return self.substring(from: self.index(self.startIndex, offsetBy: from))
    }
    //MARK : - Email validation
    var isEmailValid: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    //MARK : - Password validation
    var isPasswordValid: Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^.{6,}$")
        return passwordTest.evaluate(with: self)
    }
    //MARK : - Password validation
    var isStrongPassword: Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{6,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    //MARK : - Is name valid
    var isNameValid: Bool {
        let regex = try! NSRegularExpression(pattern: ".*[^A-Za-z].*", options: NSRegularExpression.Options())
        if regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(), range:NSMakeRange(0, self.count)) != nil {
            return false
        } else {
            return true
        }
    }
    //MARK : - Converting Date Format
    func convertToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.date(from: self)!
    }
    //MARK : - Convert Emoji to Unicode
    func converEmojiToUnicode() -> String {
        let data = self.data(using: String.Encoding.nonLossyASCII)
        let finalString = String.init(data: data!, encoding: String.Encoding.utf8)
        return finalString!
    }
    //MARK : - Convert Unicode to Emoji
    func covertUnicodeToEmoji() -> String {
        let updatedString = self.replacingOccurrences(of: "\\\\", with: "\\")
        let data = updatedString.data(using: String.Encoding.utf8, allowLossyConversion: true)
        let finalString = String.init(data: data!, encoding: String.Encoding.nonLossyASCII)
        return finalString!
    }
}
