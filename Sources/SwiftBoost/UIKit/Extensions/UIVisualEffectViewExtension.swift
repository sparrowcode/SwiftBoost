#if canImport(UIKit) && (os(iOS) || os(tvOS))
import UIKit

public extension UIVisualEffectView {
    
    convenience init(style: UIBlurEffect.Style) {
        let effect = UIBlurEffect(style: style)
        self.init(effect: effect)
    }
}
#endif
