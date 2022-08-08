#if canImport(UIKit) && (os(iOS) || os(tvOS))
import UIKit

public extension UIButton {
    
    func setTitle(_ title: String) {
        setTitle(title, for: .normal)
    }
    
    func setImage(_ image: UIImage?) {
        setImage(image, for: .normal)
        setImage(image, for: .highlighted)
        setImage(image, for: .disabled)
    }
    
    func removeTargetsAndActions() {
        self.removeTarget(nil, action: nil, for: .allEvents)
    }
}
#endif
