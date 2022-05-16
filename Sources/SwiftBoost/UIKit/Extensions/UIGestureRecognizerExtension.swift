#if canImport(UIKit) && (os(iOS) || os(tvOS))
import UIKit

public extension UIGestureRecognizer {
    
    func removeFromView() {
        view?.removeGestureRecognizer(self)
    }
}
#endif
