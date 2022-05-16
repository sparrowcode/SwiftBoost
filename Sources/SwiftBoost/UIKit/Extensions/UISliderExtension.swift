#if canImport(UIKit) && os(iOS)
import UIKit

public extension UISlider {
    
    func setValue(
        _ value: Float,
        animated: Bool = true,
        duration: TimeInterval,
        completion: (() -> Void)? = nil) {
            
            if animated {
                UIView.animate(withDuration: duration, animations: {
                    self.setValue(value, animated: true)
                }, completion: { _ in
                    completion?()
                })
            } else {
                setValue(value, animated: false)
                completion?()
            }
        }
}
#endif
