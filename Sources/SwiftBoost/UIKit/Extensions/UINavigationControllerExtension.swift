#if canImport(UIKit) && (os(iOS) || os(tvOS))
import UIKit

public extension UINavigationController {
    
    convenience init(rootViewController: UIViewController, prefersLargeTitles: Bool) {
        self.init(rootViewController: rootViewController)
        #if os(iOS)
        navigationBar.prefersLargeTitles = prefersLargeTitles
        #endif
    }
    
    
    func popViewController(animated: Bool = true, _ completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: animated)
        CATransaction.commit()
    }
    
    func pushViewController(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: true)
        CATransaction.commit()
    }
}
#endif
