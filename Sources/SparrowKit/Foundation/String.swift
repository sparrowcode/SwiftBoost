// The MIT License (MIT)
// Copyright © 2020 Ivan Varabei (varabeis@icloud.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#if canImport(Foundation)
import Foundation

extension String {
    
    var words: [String] {
        return components(separatedBy: .punctuationCharacters).joined().components(separatedBy: .whitespaces)
    }
    
    var isValidEmail: Bool {
        let regex =
            "^(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])$"
        return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    var isValidUrl: Bool {
        return URL(string: self) != nil
    }
    
    var url: URL? {
        return URL(string: self)
    }
    
    var bool: Bool? {
        let selfLowercased = trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        switch selfLowercased {
        case "true", "yes", "1":
            return true
        case "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    
    var isEmptyContent: Bool {
        let filtered = self.components(separatedBy: .whitespacesAndNewlines).joined()
        return filtered == ""
    }
    
    func uppercasedFirstLetter() -> String {
        let lowercaseSctring = self.lowercased()
        return lowercaseSctring.prefix(1).uppercased() + lowercaseSctring.dropFirst()
    }
    
    mutating func uppercaseFirstLetter() {
        self = self.uppercasedFirstLetter()
    }
    
    func removedWhitespaces() -> String {
         return self.components(separatedBy: .whitespaces).joined()
    }
    
    mutating func removeWhitespaces() {
        self = self.removedWhitespaces()
    }
    
    mutating func dropLast(substring: String) {
        if self.hasSuffix(substring) {
            self = String(dropLast(substring.count))
        }
    }
    
    mutating func dropFirst(substring: String) {
        if self.hasPrefix(substring) {
            self = String(dropFirst(substring.count))
        }
    }
    
    func dropLast(substring: String) -> String {
        if self.hasSuffix(substring) {
            return String(dropLast(substring.count))
        } else {
            return self
        }
    }
    
    func dropFirst(substring: String) -> String {
        if self.hasPrefix(substring) {
            return String(dropFirst(substring.count))
        } else {
            return self
        }
    }
    
    mutating func replace(_ replacingString: String, with newString: String) {
        self = self.replacingOccurrences(of: replacingString, with: newString)
    }
    
    func replace(_ replacingString: String, with newString: String) -> String {
        return self.replacingOccurrences(of: replacingString, with: newString)
    }
    
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}
#endif
