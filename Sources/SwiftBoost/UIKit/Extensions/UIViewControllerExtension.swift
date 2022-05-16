#if canImport(UIKit) && (os(iOS) || os(tvOS))
import UIKit

public extension UIViewController {
    
    // MARK: - Layout
    
    var systemSafeAreaInsets: UIEdgeInsets {
        return UIEdgeInsets(
            top: view.safeAreaInsets.top - additionalSafeAreaInsets.top,
            left: view.safeAreaInsets.left - additionalSafeAreaInsets.left,
            bottom: view.safeAreaInsets.bottom - additionalSafeAreaInsets.bottom,
            right: view.safeAreaInsets.right - additionalSafeAreaInsets.right
        )
    }
    
    // MARK: - Containers
    
    func addChildWithView(_ childController: UIViewController, to containerView: UIView) {
        addChild(childController)
        
        switch childController {
        case let collectionController as UICollectionViewController:
            containerView.addSubview(collectionController.collectionView)
        case let tableController as UITableViewController:
            containerView.addSubview(tableController.tableView)
        default:
            containerView.addSubview(childController.view)
        }
        
        childController.didMove(toParent: self)
    }
    
    // MARK: - Present, Dismiss and Destruct
    
    func present(_ viewControllerToPresent: UIViewController, completion: (ClosureVoid)? = nil) {
        self.present(viewControllerToPresent, animated: true, completion: completion)
    }
    
    @available(iOSApplicationExtension, unavailable)
    @available(tvOSApplicationExtension, unavailable)
    func destruct(scene name: String) {
        guard let session = view.window?.windowScene?.session else {
            dismissAnimated()
            return
        }
        if session.configuration.name == name {
            UIApplication.shared.requestSceneSessionDestruction(session, options: nil)
        } else {
            dismissAnimated()
        }
    }
    
    @objc func dismissAnimated() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Bar Button Items
    
    #if os(iOS)
    var closeBarButtonItem: UIBarButtonItem {
        if #available(iOS 14.0, *) {
            return UIBarButtonItem.init(systemItem: .close, primaryAction: .init(handler: { [weak self] (action) in
                self?.dismissAnimated()
            }), menu: nil)
        } else {
            return UIBarButtonItem.init(barButtonSystemItem: .close, target: self, action: #selector(self.dismissAnimated))
        }
    }
    
    @available(iOS 14, *)
    @available(iOSApplicationExtension, unavailable)
    func closeBarButtonItem(sceneName: String? = nil) -> UIBarButtonItem {
        return UIBarButtonItem.init(systemItem: .close, primaryAction: .init(handler: { [weak self] (action) in
            guard let self = self else { return }
            if let name = sceneName {
                self.destruct(scene: name)
            } else {
                self.dismissAnimated()
            }
        }), menu: nil)
    }
    #endif
    
    // MARK: - Keyboard
    
    func dismissKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboardTappedAround(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboardTappedAround(_ gestureRecognizer: UIPanGestureRecognizer) {
        dismissKeyboard()
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
#endif

