#if canImport(UIKit)
import UIKit

public extension UIEdgeInsets {
    
    init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
    
    init(side: CGFloat) {
        self.init(top: side, left: side, bottom: side, right: side)
    }
}
#endif
