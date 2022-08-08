#if canImport(UIKit)
import UIKit

public extension UIColor {
    
    // MARK: - Init
    
    #if !os(watchOS)
    convenience init(light: UIColor, dark: UIColor) {
        if #available(iOS 13.0, tvOS 13.0, *) {
            self.init(dynamicProvider: { trait in
                trait.userInterfaceStyle == .dark ? dark : light
            })
        } else {
            self.init(cgColor: light.cgColor)
        }
    }
    #endif
    
    #if !os(watchOS) && !os(tvOS)
    convenience init(baseInterfaceLevel: UIColor, elevatedInterfaceLevel: UIColor ) {
        if #available(iOS 13.0, tvOS 13.0, *) {
            self.init { traitCollection in
                switch traitCollection.userInterfaceLevel {
                case .base:
                    return baseInterfaceLevel
                case .elevated:
                    return elevatedInterfaceLevel
                case .unspecified:
                    return baseInterfaceLevel
                @unknown default:
                    return baseInterfaceLevel
                }
            }
        }
        else {
            self.init(cgColor: baseInterfaceLevel.cgColor)
        }
    }
    #endif
    
    convenience init(hex: String) {
        let hex = UIColor.parseHex(hex: hex, alpha: nil)
        self.init(red: hex.red, green: hex.green, blue: hex.blue, alpha: hex.alpha)
    }
    
    convenience init(hex: String, alpha: CGFloat) {
        let hex = UIColor.parseHex(hex: hex, alpha: alpha)
        self.init(red: hex.red, green: hex.green, blue: hex.blue, alpha: hex.alpha)
    }
    
    // MARK: - Application
    
    #if !os(watchOS)
    @available(iOSApplicationExtension, unavailable)
    @available(tvOSApplicationExtension, unavailable)
    static var tint: UIColor {
        get {
            let value = UIApplication.shared.windows.first?.tintColor
            guard let tint = value else { return .systemBlue }
            return tint
        }
        set {
            UIApplication.shared.windows.forEach({ $0.tintColor = newValue })
        }
    }
    #endif
    
    // MARK: - Helpers
    
    var hex: String {
        let colorRef = cgColor.components
        let r = colorRef?[0] ?? 0
        let g = colorRef?[1] ?? 0
        let b = ((colorRef?.count ?? 0) > 2 ? colorRef?[2] : g) ?? 0
        let a = cgColor.alpha
        
        var color = String(
            format: "#%02lX%02lX%02lX",
            lroundf(Float(r * 255)),
            lroundf(Float(g * 255)),
            lroundf(Float(b * 255))
        )
        
        if a < 1 {
            color += String(format: "%02lX", lroundf(Float(a)))
        }
        
        return color
    }
    
    func alpha(_ alpha: CGFloat) -> UIColor {
        self.withAlphaComponent(alpha)
    }
    
    #if !os(watchOS)
    var alpha: CGFloat { CIColor(color: self).alpha }
    #endif
    
    func lighter(by amount: CGFloat) -> UIColor { mixWithColor(UIColor.white, amount: amount) }
    func darker(by amount: CGFloat) -> UIColor { mixWithColor(UIColor.black, amount: amount) }
    
    func mixWithColor(_ color: UIColor, amount: CGFloat = 0.25) -> UIColor {
        var r1     : CGFloat = 0
        var g1     : CGFloat = 0
        var b1     : CGFloat = 0
        var alpha1 : CGFloat = 0
        var r2     : CGFloat = 0
        var g2     : CGFloat = 0
        var b2     : CGFloat = 0
        var alpha2 : CGFloat = 0
        
        self.getRed (&r1, green: &g1, blue: &b1, alpha: &alpha1)
        color.getRed(&r2, green: &g2, blue: &b2, alpha: &alpha2)
        return UIColor(
            red: r1 * (1.0 - amount) + r2 * amount,
            green: g1 * (1.0 - amount) + g2 * amount,
            blue: b1 * (1.0 - amount) + b2 * amount,
            alpha: alpha1)
    }
    
    private static func parseHex(hex: String, alpha: CGFloat?) -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var newAlpha: CGFloat = alpha ?? 1.0
        var hex:   String = hex
        
        if hex.hasPrefix("#") {
            let index = hex.index(hex.startIndex, offsetBy: 1)
            hex = String(hex[index...])
        }
        
        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        if scanner.scanHexInt64(&hexValue) {
            switch (hex.count) {
            case 3:
                red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                blue  = CGFloat(hexValue & 0x00F)              / 15.0
            case 4:
                red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                if alpha == nil {
                    newAlpha = CGFloat(hexValue & 0x000F)      / 15.0
                }
            case 6:
                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                if alpha == nil {
                    newAlpha = CGFloat(hexValue & 0x000000FF)  / 255.0
                }
            default:
                print("UIColorExtension - Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8")
            }
        } else {
            print("UIColorExtension - Scan hex error")
        }
        return (red, green, blue, newAlpha)
    }
    
    // MARK: - Data
    
    #if !os(watchOS)
    static var systemColorfulColors: [UIColor] {
        if #available(iOS 13.0, tvOS 13.0, *) {
            return [.systemRed, .systemOrange, .systemYellow, .systemGreen, .systemTeal, .systemBlue, .systemIndigo, .systemPink, .systemPurple]
        } else {
            return [.systemRed, .systemOrange, .systemYellow, .systemGreen, .systemTeal, .systemBlue, .systemPink, .systemPurple]
        }
    }
    #endif
    
    var secondary: UIColor {
        return self.alpha(0.06)
    }
    
    #if !os(watchOS) && !os(tvOS)
    static var footnoteColor: UIColor {
        if #available(iOS 13.0, tvOS 13, *) {
            return UIColor.init { (trait) -> UIColor in
                return trait.userInterfaceStyle == .dark ? UIColor(hex: "8E8E93") : UIColor(hex: "6D6D72")
            }
        } else {
            return UIColor(hex: "6D6D72")
        }
    }
    #endif
    
    #if !os(watchOS)
    static var destructiveColor: UIColor { .systemRed }
    static var warningColor: UIColor { .systemOrange }
    #endif
}
#endif
