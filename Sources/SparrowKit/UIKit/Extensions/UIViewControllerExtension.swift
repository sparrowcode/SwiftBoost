// The MIT License (MIT)
// Copyright © 2020 Ivan Vorobei (hello@ivanvorobei.io)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#if canImport(UIKit) && (os(iOS) || os(tvOS))
import UIKit

extension UIViewController {
    
    // MARK: - Layout
    
    /**
     SparrowKit: System safe area without `additionalSafeAreaInsets`.
     
     Usually same as window's safe area, but not always if you use not full screen controller. For solve it trouble use it for have valid safe area to view.
     */
    open var systemSafeAreaInsets: UIEdgeInsets {
        return UIEdgeInsets(
            top: view.safeAreaInsets.top - additionalSafeAreaInsets.top,
            left: view.safeAreaInsets.left - additionalSafeAreaInsets.left,
            bottom: view.safeAreaInsets.bottom - additionalSafeAreaInsets.bottom,
            right: view.safeAreaInsets.right - additionalSafeAreaInsets.right
        )
    }
    
    // MARK: - Containers
    
    /**
     SparrowKit: Wrap controller to navigation controller.
     
     - parameter prefersLargeTitles: A Boolean value indicating whether the title should be displayed in a large format.
     */
    @objc open func wrapToNavigationController(prefersLargeTitles: Bool) -> SPNavigationController {
        let navigationController = SPNavigationController(rootViewController: self)
        #if os(iOS)
        navigationController.navigationBar.prefersLargeTitles = prefersLargeTitles
        #endif
        return navigationController
    }
    
    /**
     SparrowKit: Adds the specified view controller as a child of the current view controller.
     
     - parameter childController: Specific controller which using as child.
     - parameter containerView: Conteiner which using to add a view of child controller.
     */
    open func addChildWithView(_ childController: UIViewController, to containerView: UIView) {
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
    
    /**
     SparrowKit: Indicate if controller is loaded and presented.
     */
    open var isVisible: Bool {
        return isViewLoaded && view.window != nil
    }
    
    /**
     SparrowKit: Removed property `animated`, always `true`.
     */
    open func present(_ viewControllerToPresent: UIViewController, completion: (() -> Swift.Void)? = nil) {
        self.present(viewControllerToPresent, animated: true, completion: completion)
    }
    
    /**
     SparrowKit: If scene name is same as
     */
    @available(iOS 13, tvOS 13, *)
    @available(iOSApplicationExtension, unavailable)
    @available(tvOSApplicationExtension, unavailable)
    open func destruct(scene name: String) {
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
    
    /**
     SparrowKit: Dismiss always animated.
     */
    @objc open func dismissAnimated() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Bar Button Items
    
    /**
     SparrowKit: Make bar button item which automatically dismiss controller animated.
     */
    #if os(iOS)
    @available(iOS 13, *)
    open var closeBarButtonItem: UIBarButtonItem {
        if #available(iOS 14.0, *) {
            return UIBarButtonItem.init(systemItem: .close, primaryAction: .init(handler: { [weak self] (action) in
                self?.dismissAnimated()
            }), menu: nil)
        } else {
            return UIBarButtonItem.init(barButtonSystemItem: .close, target: self, action: #selector(self.dismissAnimated))
        }
    }
    #endif
    
    /**
     SparrowKit: Make bar button item which automatically dismiss controller animated and if available, try close scene.
     
     Scene compared with id which passing.
     
     - parameter sceneName: ID of scene if which detected will be closed.
     */
    #if os(iOS)
    @available(iOS 14, *)
    @available(iOSApplicationExtension, unavailable)
    open func closeBarButtonItem(sceneName: String? = nil) -> UIBarButtonItem {
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
    
    /**
     SparrowKit: Added gester which observe when tap need hide keyboard.
     Shoud add below of using views like textfuilds.
     */
    open func dismissKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboardTappedAround(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    /**
     SparrowKit: Internal method which process tap around for hide keyboard.
     No need call it manually.
     */
    @objc open func dismissKeyboardTappedAround(_ gestureRecognizer: UIPanGestureRecognizer) {
        dismissKeyboard()
    }
    
    /**
     SparrowKit: Hide keyboard.
     */
    open func dismissKeyboard() {
        view.endEditing(true)
    }
}
#endif

