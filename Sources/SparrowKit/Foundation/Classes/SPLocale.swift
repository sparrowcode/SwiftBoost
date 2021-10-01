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

import Foundation

public enum SPLocale: String {
    
    case ru = "ru"                      // Russian
    case en = "en"                      // English
    case uk = "uk"                      // Ukrainian
    case es = "es"                      // Spanish
    case ar = "ar"                      // Arabic
    case fa = "fa"                      // Persian
    case de = "de"                      // German
    case fr = "fr"                      // French
    case it = "it"                      // Italian
    case nl = "nl"                      // Dutch
    case id = "id"                      // Indonesian
    case ms = "ms"                      // Malay
    case tr = "tr"                      // Turkish
    case hy = "hy"                      // Armenian
    case zh = "zh"                      // Chinese
    case ja = "ja"                      // Japanese
    case ur = "ur"                      // Urdu
    case be = "be"                      // Belarusian
    case pt = "pt"                      // Portuguese
    case pl = "pl"                      // Polish
    case gsw = "gsw"                    // Swiss German
    case fil = "fil"                    // Filipino
    
    /**
     SparrowKit: Uniq identifier.
     */
    public var identifier: String { rawValue }
    
    /**
     SparrowKit: Code if language which using Apple without split.
     */
    public var languageCode: String { rawValue }
    
    /**
     SparrowKit: Current locale, which using in app
     */
    public static var current: SPLocale {
        get {
            var code = Locale.preferredLanguages.first ?? "en"
            var locale = SPLocale(rawValue: code)
            if locale == nil {
                code = String(code.split(separator: "-").first ?? "en")
                locale = SPLocale(rawValue: code)
            }
            return locale ?? .en
        }
    }
    
    /**
     SparrowKit: Localize description of language.
     */
    @available(iOS 11.0, tvOS 11.0, macOS 10.11, *)
    public func description(in locale: SPLocale) -> String {
        let locale = NSLocale(localeIdentifier: locale.languageCode)
        let text = locale.displayName(forKey: NSLocale.Key.identifier, value: languageCode) ?? .empty
        return text.localizedCapitalized
    }
}
