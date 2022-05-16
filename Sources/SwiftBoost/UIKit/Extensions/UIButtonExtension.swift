#if canImport(UIKit) && (os(iOS) || os(tvOS))
import UIKit

public extension UIButton {
    
    func setTitle(_ title: String) {
        if #available(iOS 15.0, *) {
            configuration?.title = title
        } else {
            setTitle(title, for: .normal)
        }
    }
    
    func setImage(_ image: UIImage?) {
        if #available(iOS 15.0, *) {
            configuration?.image = image
        } else {
            setImage(image, for: .normal)
            setImage(image, for: .highlighted)
            setImage(image, for: .disabled)
        }
    }
    
    func removeTargetsAndActions() {
        self.removeTarget(nil, action: nil, for: .allEvents)
    }
}
#endif
