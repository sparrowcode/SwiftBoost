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
    
    /**
     SparrowKit: If set to `true`, child controllers apply horizontal margins from view of navigation controller.
     Default is `false`.
     */
    open var inheritLayoutMarginsForСhilds: Bool = false
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Inhert of Navigation Bar
        
        if inheritLayoutMarginsForNavigationBar {
            
            let leftMargin = view.layoutMargins.left
            let rightMargin = view.layoutMargins.left
            
            if navigationBar.layoutMargins.left != leftMargin {
                navigationBar.layoutMargins.left = leftMargin
            }
            if navigationBar.layoutMargins.right != rightMargin {
                navigationBar.layoutMargins.right = rightMargin
            }
        }
        
        // Inhert childs controllers
        
        if inheritLayoutMarginsForСhilds {
            let leftMargin = view.layoutMargins.left
            let rightMargin = view.layoutMargins.left
            
            for childController in viewControllers {
                if childController.view.layoutMargins.left != leftMargin {
                    childController.view.layoutMargins.left = leftMargin
                }
                if childController.view.layoutMargins.right != rightMargin {
                    childController.view.layoutMargins.right = rightMargin
                }
            }
        }
    }
}
#endif
