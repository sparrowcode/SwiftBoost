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

public extension UITabBarController {
    
    /**
     SparrowKit: Add tab bar.
     
     - parameter controller: Controller which show by tap on bar.
     - parameter title: Title of bar.
     - parameter image: Default image for bar.
     - parameter selectedImage: Selected image for bar, If nil, using  default.
     */
    func addTabBarItem(with controller: UIViewController, title: String, image: UIImage, selectedImage: UIImage? = nil) {
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage ?? image)
        controller.tabBarItem = tabBarItem
        if self.viewControllers == nil { self.viewControllers = [controller] }
        else { self.viewControllers?.append(controller) }
    }
    
    /**
     SparrowKit: Add tab bar.
     
     - parameter controller: Controller which show by tap on bar.
     - parameter item: System items that can be used on a tab bar..
     - parameter tag: The receiver’s tag, an integer that you can use to identify bar item objects in your application..
     */
    func addTabBarItem(with controller: UIViewController, _ item: UITabBarItem.SystemItem, tag: Int) {
        let tabBarItem = UITabBarItem.init(tabBarSystemItem: item, tag: tag)
        controller.tabBarItem = tabBarItem
        if self.viewControllers == nil { self.viewControllers = [controller] }
        else { self.viewControllers?.append(controller) }
    }
}
#endif
