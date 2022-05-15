import Foundation

public extension String {
    
    static var empty: String { return "" }
    static var space: String { return " " }
    static var dot: String { return "." }
    static var newline: String { return "\n" }
    
    var words: [String] {
        return components(separatedBy: .punctuationCharacters).joined().components(separatedBy: .whitespaces)
    }
    
    var isEmail: Bool {
        let regex = "^(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])$"
        return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    var url: URL? { URL(string: self) }
    var isURL: Bool { self.url != nil}
    
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
    
    var trim: String { trimmingCharacters(in: .whitespacesAndNewlines) }
    var isEmptyContent: Bool { trim == .empty }
    
    // MARK: - Edit
    
    func uppercasedFirstLetter() -> String {
        let lowercaseSctring = self.lowercased()
        return lowercaseSctring.prefix(1).uppercased() + lowercaseSctring.dropFirst()
    }
    
    func removedSuffix(_ suffix: String) -> String {
        if self.hasSuffix(suffix) {
            return String(dropLast(suffix.count))
        } else {
            return self
        }
    }
    
    func removedPrefix(_ prefix: String) -> String {
        if self.hasPrefix(prefix) {
            return String(dropFirst(prefix.count))
        } else {
            return self
        }
    }
    
    func replace(_ replacingString: String, with newString: String) -> String {
        return self.replacingOccurrences(of: replacingString, with: newString)
    }
}
