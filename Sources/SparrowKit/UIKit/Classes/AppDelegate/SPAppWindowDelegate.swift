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
 SparrowKit:  App Delegate which not using with scenes, only with one window key.
 */
open class SPAppWindowDelegate: SPAppDelegate {
    
    /**
     SparrowKit:  Ready-use window property.
     
     For correct configure, call `makeKeyAndVisible`.
     */
    open var window: UIWindow?
    
    /**
     SparrowKit: Configure window and make it present.
     
     Method init window and configure with your tint and controller.
     
     - warning:
     Use it only if none-scene mode.
     
     - parameter scene: Scene which sync to window.
     - parameter tint: Tint color for window.
     - parameter createViewControllerHandler: Handler for get root controller for window.
     */
    open func makeKeyAndVisible(createViewControllerHandler: () -> UIViewController, tint: UIColor) {
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
        window?.tintColor = tint
        window?.rootViewController = createViewControllerHandler()
        window?.makeKeyAndVisible()
    }
    
    /**
     SparrowKit: Configure window and make it present.
     
     Method init window and configure with your tint and controller.
     
     - warning:
     Use it only if none-scene mode.
     
     - parameter tint: Tint color for window.
     - parameter viewController: Root controller for window.
     */
    open func makeKeyAndVisible(viewController: UIViewController, tint: UIColor) {
        makeKeyAndVisible(createViewControllerHandler: {
            return viewController
        }, tint: tint)
    }
}
#endif
