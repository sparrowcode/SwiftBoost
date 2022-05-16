#if canImport(UIKit) && (os(iOS) || os(tvOS))
import UIKit

public extension UILabel {
    
    // MARK: - Helpers
    
    var letterSpace: CGFloat {
        set {
            let attributedString: NSMutableAttributedString!
            if let currentAttrString = attributedText {
                attributedString = NSMutableAttributedString(attributedString: currentAttrString)
            } else {
                attributedString = NSMutableAttributedString(string: text ?? "")
                text = nil
            }
            attributedString.addAttribute(NSAttributedString.Key.kern, value: newValue, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
        get {
            if let currentLetterSpace = attributedText?.attribute(NSAttributedString.Key.kern, at: 0, effectiveRange: .none) as? CGFloat {
                return currentLetterSpace
            } else {
                return 0
            }
        }
    }
    
    // MARK: - Layout
    
    func layoutDynamicHeight() {
        sizeToFit()
    }
    
    func layoutDynamicHeight(width: CGFloat) {
        frame.setWidth(width)
        sizeToFit()
        if frame.width != width {
            frame.setWidth(width)
        }
    }
    
    func layoutDynamicHeight(x: CGFloat, y: CGFloat, width: CGFloat) {
        frame = CGRect.init(x: x, y: y, width: width, height: frame.height)
        sizeToFit()
        if frame.width != width {
            frame.setWidth(width)
        }
    }
}
#endif
