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
        
        func supportedLangCodeId(for locale: Locale) -> String? {
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
