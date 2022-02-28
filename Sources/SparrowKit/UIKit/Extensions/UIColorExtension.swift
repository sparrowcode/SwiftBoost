// The MIT License (MIT)
// Copyright © 2020 Ivan Vorobei (hello@ivanvorobei.io)
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

#if canImport(UIKit)
import UIKit

extension UIColor {
    
    // MARK: - Init
    
    #if !os(watchOS)
    /**
     SparrowKit: Create dynamic color for light and dark user interface style.
     
     - parameter light: Color for light interface style.
     - parameter dark: Color for dark interface style.
     */
    public convenience init(light: UIColor, dark: UIColor) {
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
    /**
     SparrowKit: Create color for interface levels.
     
     - parameter baseInterfaceLevel: Color for basic interface level.
     - parameter elevatedInterfaceLevel: Color for elevated interface level.
     */
    public convenience init(baseInterfaceLevel: UIColor, elevatedInterfaceLevel: UIColor ) {
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
    
    /**
     SparrowKit: Create color by HEX.
     
     - parameter hex: HEX of color. Can start from #.
     */
    public convenience init(hex: String) {
        let hex = UIColor.parseHex(hex: hex, alpha: nil)
        self.init(red: hex.red, green: hex.green, blue: hex.blue, alpha: hex.alpha)
    }
    
    /**
     SparrowKit: Create color by HEX.
     
     - parameter hex: HEX of color. Can start from #.
     - parameter alpha: Opacity.
     */
    public convenience init(hex: String, alpha: CGFloat) {
        let hex = UIColor.parseHex(hex: hex, alpha: alpha)
        self.init(red: hex.red, green: hex.green, blue: hex.blue, alpha: hex.alpha)
    }
    
    // MARK: - Application
    
    #if !os(watchOS)
    /**
     SparrowKit: Tint color for first window.
     Usually it is global tint color.
     */
    @available(iOSApplicationExtension, unavailable)
    @available(tvOSApplicationExtension, unavailable)
    public static var tint: UIColor {
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
    
    /**
     SparrowKit: Get HEX from current color.
     */
    public var hex: String {
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
    
    /**
     SparrowKit: Color with new opacity.
     
     - parameter alpha: Opacity.
     */
    public func alpha(_ alpha: CGFloat) -> UIColor {
        self.withAlphaComponent(alpha)
    }
    
    /**
     SparrowKit: Make color lighter.
     
     - parameter amount: Amount for lighter. Use 0...1.
     */
    public func lighter(by amount: CGFloat) -> UIColor {
        return mixWithColor(UIColor.white, amount: amount)
    }
    
    /**
     SparrowKit: Make color darker.
     
     - parameter amount: Amount for darker. Use 0...1.
     */
    public func darker(by amount: CGFloat) -> UIColor {
        return mixWithColor(UIColor.black, amount: amount)
    }
    
    /**
     SparrowKit: Mix with other color.
     
     - parameter color: Color for mix.
     - parameter amount: Amount of mix. Use 0...1.
     */
    public func mixWithColor(_ color: UIColor, amount: CGFloat = 0.25) -> UIColor {
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
    
    #if !os(watchOS)
    /**
     SparrowKit: Get Alpha.
     */
    public var alpha: CGFloat {
        CIColor(color: self).alpha
    }
    #endif
    
    /**
     SparrowKit: Convert HEX to RGB channels.
     
     - parameter hex: HEX of color.
     - parameter alpha: Opacity.
     */
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
                SPLogger.kit(message: "UIColorExtension - Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8")
            }
        } else {
            SPLogger.kit(message: "UIColorExtension - Scan hex error")
        }
        return (red, green, blue, newAlpha)
    }
    
    // MARK: - Data
    
    #if !os(watchOS)
    /**
     SparrowKit: List of colorful colors.
     */
    public static var systemColorfulColors: [UIColor] {
        if #available(iOS 13.0, tvOS 13.0, *) {
            return [.systemRed, .systemOrange, .systemYellow, .systemGreen, .systemTeal, .systemBlue, .systemIndigo, .systemPink, .systemPurple]
        } else {
            return [.systemRed, .systemOrange, .systemYellow, .systemGreen, .systemTeal, .systemBlue, .systemPink, .systemPurple]
        }
    }
    #endif
    
    /**
     SparrowKit: Using like secondary color usually for background of colorful element.
     
     - parameter background: Pass color of background of element.
     - important: In design for tint color get 6% alpha.
     Also color depended of background, so it reason why it requerid.
     */
    public var secondary: UIColor {
        return self.alpha(0.06)
        
        // Old version for fill color
        /*
         return UIColor.init(dynamicProvider: { trait in
            if trait.userInterfaceStyle == .light {
                return self.mixWithColor(background, amount: 0.9)
            } else {
                return self.mixWithColor(background, amount: 0.9)
            }
        })*/
    }
    
    #if !os(watchOS) && !os(tvOS)
    /**
     SparrowKit: Color of footnote label.
     */
    public static var footnoteColor: UIColor {
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
    /**
     SparrowKit: Wrapper of destructive actions color.
     */
    public static var destructiveColor: UIColor { .systemRed }
    #endif
    
    #if !os(watchOS)
    /**
     SparrowKit: Wrapper of warning actions color.
     */
    public static var warningColor: UIColor { .systemOrange }
    #endif
    
    #if os(iOS)
    /**
     SparrowKit: New color to system stack.
     Its color for empty areas and it usually downed of main background color.
     */
    @available(iOS 13.0, *)
    public static var systemDownedBackground: UIColor {
        let lightColor = UIColor.secondarySystemBackground.mixWithColor(.darkGray, amount: 0.09).mixWithColor(UIColor.systemBlue, amount: 0.01)
        let darkColor = UIColor.secondarySystemBackground
        return UIColor.init(light: lightColor, dark: darkColor)
    }
    #endif
    
    
    #if os(iOS)
    /**
     SparrowKit: New color to system grouped stack.
     Its color for empty aread and it usually downed of content background color.
     */
    @available(iOS 13.0, *)
    public static var systemDownedGroupedBackground: UIColor {
        return UIColor.init(dynamicProvider: { trait in
            if trait.userInterfaceStyle == .light {
                return UIColor.systemGroupedBackground.mixWithColor(.darkGray, amount: 0.09).mixWithColor(UIColor.systemBlue, amount: 0.01)
            } else {
                return UIColor.secondarySystemGroupedBackground.alpha(0.7)
            }
        })
    }
    #endif

    #if !os(watchOS)
    /**
     SparrowKit: Dimmed content color.
     */
    public static var dimmedContent: UIColor {
        if #available(iOS 13, tvOS 13, *) {
            return UIColor.secondaryLabel
        } else {
            return UIColor(hex: "3c3c4399")
        }
    }
    #endif
    
    #if !os(watchOS)
    /**
     SparrowKit: Dimmed background color.
     */
    public static var dimmedBackground: UIColor {
        dimmedContent.alpha(0.1)
    }
    #endif
}
#endif
