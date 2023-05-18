import Foundation

public extension Locale {
    
    var is12HourTimeFormat: Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        dateFormatter.locale = self
        let dateString = dateFormatter.string(from: Date())
        return dateString.contains(dateFormatter.amSymbol) || dateString.contains(dateFormatter.pmSymbol)
    }
    
    func localised(in locale: Locale) -> String? {
        /**
         Returns the identifier for the language code of the given `Locale`.

         This method checks for the availability of specific APIs introduced in iOS 16.0 and macOS 13.0 versions or later. If these APIs are available, it returns the `identifier` property of the `languageCode` from the `Locale`. Otherwise, it uses the `languageCode` property directly from the `Locale`.

         - Parameter locale: The `Locale` for which the language code identifier is required.

         - Returns: The language code identifier of the given `Locale`. If the specific APIs are unavailable (i.e., the device's OS version is older than iOS 16.0 or macOS 13.0), it returns the language code directly.
         */
        func supportedLangCodeId(for locale: Locale) -> String? {
            //  Checks for the availability of specific APIs introduced in iOS 16.0 and macOS 13.0 versions or later.
            if #available(iOS 16.0, macOS 13.0, *) {
                return locale.language.languageCode?.identifier
            } else {
                return locale.languageCode
            }
        }
        
        guard let currentLanguageCode = {
            supportedLangCodeId(for: self)
        }() else { return nil }
        guard let toLanguageCode = {
            supportedLangCodeId(for: locale)
        }() else { return nil }
        let nslocale = NSLocale(localeIdentifier: toLanguageCode)
        let text = nslocale.displayName(forKey: NSLocale.Key.identifier, value: currentLanguageCode)
        return text?.localizedCapitalized
    }
    
    static func flagEmoji(forRegionCode isoRegionCode: String) -> String? {
        guard isoRegionCodes.contains(isoRegionCode) else { return nil }
        return isoRegionCode.unicodeScalars.reduce(into: String()) {
            guard let flagScalar = UnicodeScalar(UInt32(127_397) + $1.value) else { return }
            $0.unicodeScalars.append(flagScalar)
        }
    }
}
