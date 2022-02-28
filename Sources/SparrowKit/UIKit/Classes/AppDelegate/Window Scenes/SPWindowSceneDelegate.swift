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

#if canImport(UIKit) && (os(iOS))
import UIKit

/**
 SparrowKit: Basic class for scene delegate.
 
 Has ready use window property and assets funcs for present window.
 */
@available(iOS 13.0, *)
open class SPWindowSceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    /**
     SparrowKit: Ready-use window property.
     
     For correct configure, call `makeKeyAndVisible`.
     */
    open var window: UIWindow?
    
    /**
     SparrowKit: Configure window and make it present.
     
     This method get controller after apply tint and window scene, in some cases it critical. For example tint of window get before valid tint set. It happen with first window and launch. For solve it use this.
     
     - parameter scene: Scene which sync to window.
     - parameter tint: Tint color for window.
     - parameter createViewControllerHandler: Handler for get root controller for window.
     */
    open func makeKeyAndVisible(in scene: UIWindowScene, createViewControllerHandler: () -> UIViewController, tint: UIColor) {
        window = UIWindow(frame: scene.coordinateSpace.bounds)
        window?.windowScene = scene
        window?.tintColor = tint
        window?.rootViewController = createViewControllerHandler()
        window?.makeKeyAndVisible()
    }
    
    /**
     SparrowKit: Configure window and make it present.
     
     Set scene, tint and already created controller.
     
     - warning:
     If you get troubles with tinting, please, check other method `makeKeyAndVisible`.
     
     - parameter scene: Scene which sync to window.
     - parameter tint: Tint color for window.
     - parameter viewController: Root controller for window.
     */
    open func makeKeyAndVisible(in scene: UIWindowScene, viewController: UIViewController, tint: UIColor) {
        makeKeyAndVisible(in: scene, createViewControllerHandler: {
            return viewController
        }, tint: tint)
    }
}
#endif
