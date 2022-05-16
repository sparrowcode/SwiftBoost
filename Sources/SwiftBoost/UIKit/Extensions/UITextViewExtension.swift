#if canImport(UIKit) && (os(iOS) || os(tvOS))
import UIKit

public extension UITextView {
    
    func layoutDynamicHeight(width: CGFloat) {
        // Requerid for dynamic height.
        if isScrollEnabled { isScrollEnabled = false }
        
        frame.setWidth(width)
        sizeToFit()
        if frame.width != width {
            frame.setWidth(width)
        }
    }
    
    func layoutDynamicHeight(x: CGFloat, y: CGFloat, width: CGFloat) {
        // Requerid for dynamic height.
        if isScrollEnabled { isScrollEnabled = false }
        
        frame = CGRect.init(x: x, y: y, width: width, height: frame.height)
        sizeToFit()
        if frame.width != width {
            frame.setWidth(width)
        }
    }
}
#endif
