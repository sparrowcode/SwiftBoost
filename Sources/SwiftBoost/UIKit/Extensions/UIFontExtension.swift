#if canImport(UIKit) && (os(iOS) || os(tvOS))
import UIKit

public extension UIFont {
    
    var rounded: UIFont {
        if #available(iOS 13, tvOS 13, *) {
            guard let descriptor = fontDescriptor.withDesign(.rounded) else { return self }
            return UIFont(descriptor: descriptor, size: 0)
        } else {
            return self
        }
    }
    
    var monospaced: UIFont {
        if #available(iOS 13, tvOS 13, *) {
            guard let descriptor = fontDescriptor.withDesign(.monospaced) else { return self }
            return UIFont(descriptor: descriptor, size: 0)
        } else {
            return self
        }
    }
    
    var serif: UIFont {
        if #available(iOS 13, tvOS 13, *) {
            guard let descriptor = fontDescriptor.withDesign(.serif) else { return self }
            return UIFont(descriptor: descriptor, size: 0)
        } else {
            return self
        }
    }
    
    static func preferredFont(forTextStyle style: TextStyle, addPoints: CGFloat = .zero) -> UIFont {
        let referensFont = UIFont.preferredFont(forTextStyle: style)
        return referensFont.withSize(referensFont.pointSize + addPoints)
    }
    
    static func preferredFont(forTextStyle style: TextStyle, weight: Weight, addPoints: CGFloat = .zero) -> UIFont {
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        let font = UIFont.systemFont(ofSize: descriptor.pointSize + addPoints, weight: weight)
        let metrics = UIFontMetrics(forTextStyle: style)
        return metrics.scaledFont(for: font)
    }
}
#endif
