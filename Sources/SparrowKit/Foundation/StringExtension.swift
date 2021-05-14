// The MIT License (MIT)
// Copyright © 2020 Ivan Vorobei (hello@ivanvorobei.by)
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

public extension String {
    
    // MARK: - Data
    
    /**
     SparrowKit: Wrapper of emtry string "".
     */
    static var empty: String { return "" }
    
    /**
     SparrowKit: Wrapper of space string " ".
     */
    static var space: String { return " " }
    
    /**
     SparrowKit: Wrapper of dot string ".".
     */
    static var dot: String { return "." }
    
    /**
     SparrowKit: Wrapper of new line string "\n".
     */
    static var newline: String { return "\n" }
    
    // MARK: - Helpers
    
    /**
     SparrowKit: Get words in string.
     */
    var words: [String] {
        return components(separatedBy: .punctuationCharacters).joined().components(separatedBy: .whitespaces)
    }
    
    /**
     SparrowKit: Check if string is corect email.
     */
    var isValidEmail: Bool {
        let regex =
            "^(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])$"
        return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    /**
     SparrowKit: Check if string is corect url.
     */
    var isValidUrl: Bool {
        return URL(string: self) != nil
    }
    
    /**
     SparrowKit: Try get `URL` by current object.
     */
    var url: URL? {
        return URL(string: self)
    }
    
    /**
     SparrowKit: Removed whitespaces and new lines.
     */
    var trim: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /**
     SparrowKit: Convert string to double with locale.
     
     -  parameter locale: Converting `Locale`.
     */
    func double(locale: Locale = .current) -> Double? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.allowsFloats = true
        return formatter.number(from: self)?.doubleValue
    }
    
    /**
     SparrowKit: Get count of lines.
     */
    func lines() -> [String] {
        var result = [String]()
        enumerateLines { line, _ in
            result.append(line)
        }
        return result
    }
    
    /**
     SparrowKit: Try convert `String` to `Bool`.
     */
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
    
    /**
     SparrowKit: Check if string has useful content exclude spaces and new lines.
     */
    var isEmptyContent: Bool {
        let filtered = self.components(separatedBy: .whitespacesAndNewlines).joined()
        return filtered == ""
    }
    
    // MARK: - Changes
    
    /**
     SparrowKit: Uppercase first letter and returen new object.
     */
    func uppercasedFirstLetter() -> String {
        let lowercaseSctring = self.lowercased()
        return lowercaseSctring.prefix(1).uppercased() + lowercaseSctring.dropFirst()
    }
    
    /**
     SparrowKit: Uppercase first letter for current object.
     */
    mutating func uppercaseFirstLetter() {
        self = self.uppercasedFirstLetter()
    }
    
    /**
     SparrowKit: Remove suffix for string and change current object.
     
     - parameter suffix: String which need remove.
     */
    mutating func removeSuffix(_ suffix: String) {
        if self.hasSuffix(suffix) {
            self = String(dropLast(suffix.count))
        }
    }
    
    /**
     SparrowKit: Remove suffix for string and return new object.
     
     - parameter suffix: String which need remove.
     */
    func removedSuffix(_ suffix: String) -> String {
        if self.hasSuffix(suffix) {
            return String(dropLast(suffix.count))
        } else {
            return self
        }
    }
    
    /**
     SparrowKit: Remove prefix for string and change current object.
     
     - parameter prefix: String which need remove.
     */
    mutating func removePrefix(_ prefix: String) {
        if self.hasPrefix(prefix) {
            self = String(dropFirst(prefix.count))
        }
    }
    
    /**
     SparrowKit: Remove prefix for string and return new object.
     
     - parameter prefix: String which need remove.
     */
    func removedPrefix(_ prefix: String) -> String {
        if self.hasPrefix(prefix) {
            return String(dropFirst(prefix.count))
        } else {
            return self
        }
    }
    
    /**
     SparrowKit: Replace some string in current object with new string and change current object.
     
     - parameter replacingString: Searching string for replace.
     - parameter newString: Replace to this string.
     */
    mutating func replace(_ replacingString: String, with newString: String) {
        self = self.replacingOccurrences(of: replacingString, with: newString)
    }
    
    /**
     SparrowKit: Replace some string in current object with new string and return new object.
     
     - parameter replacingString: Searching string for replace.
     - parameter newString: Replace to this string.
     */
    func replace(_ replacingString: String, with newString: String) -> String {
        return self.replacingOccurrences(of: replacingString, with: newString)
    }
}
#endif
