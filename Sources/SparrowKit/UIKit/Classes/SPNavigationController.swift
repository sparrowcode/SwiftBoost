import UIKit

#if canImport(UIKit) && (os(iOS) || os(tvOS))
import UIKit

/**
 SparrowKit: Basic Navigation Controller.
 
 It has one shared init `commonInit` which call for all default inits.
 */
open class SPNavigationController: UINavigationController {
    
    // MARK: - Init
    
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        commonInit()
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
        super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
    }
    
    /**
     SparrowKit: Wrapper of init.
     Called in each init and using for configuration.
     
     No need ovveride init. Using one function for configurate view.
     */
    open func commonInit() {}
    
    // MARK: - Layout
    
    /**
     SparrowKit: If set to `true`, navigation bar apply horizontal margins from view of navigation controller.
     Default is `false`.
     */
    open var inheritLayoutMarginsForNavigationBar: Bool = false
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if inheritLayoutMarginsForNavigationBar {
            navigationBar.layoutMargins.left = view.layoutMargins.left
            navigationBar.layoutMargins.right = view.layoutMargins.right
        }
    }
}
#endif
