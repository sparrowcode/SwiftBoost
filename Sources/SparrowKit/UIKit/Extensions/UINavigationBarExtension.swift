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

extension UINavigationBar {
    
    /**
     SparrowKit: Change font of title.
     
     - parameter font: New font of title.
     */
    open func setTitleFont(_ font: UIFont) {
        titleTextAttributes = [.font: font]
    }
    
    /**
     SparrowKit: Change color of title.
     
     - parameter color: New color of title.
     */
    open func setTitleColor(_ color: UIColor) {
        titleTextAttributes = [.foregroundColor: color]
    }
    
    /**
     SparrowKit: Change background and title colors.
     
     - parameter backgroundColor: New background color of navigation.
     - parameter textColor: New text color of title.
     */
    open func setColors(backgroundColor: UIColor, textColor: UIColor) {
        isTranslucent = false
        self.backgroundColor = backgroundColor
        barTintColor = backgroundColor
        setBackgroundImage(UIImage(), for: .default)
        tintColor = textColor
        titleTextAttributes = [.foregroundColor: textColor]
    }
    
    /**
     SparrowKit: Make transparent of background of navigation.
     */
    open func makeTransparent() {
        isTranslucent = true
        backgroundColor = .clear
        barTintColor = .clear
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
    }
    
    /**
     SparrowKit: Set opacity for background view.
     */
    @available(*, deprecated, message: "Use appearance")
    open func setBackgroundAlpha(_ value: CGFloat) {
        for (index, view) in subviews.enumerated() {
            // Hide background for navigation bar.
            // Usually it first view.
            if index == .zero {
                view.alpha = value
            }
        }
    }
    
    /**
     SparrowKit: Set appearance for navigation bar.
     */
    @available(iOS 13.0, tvOS 13.0, *)
    open func setAppearance(_ value: SPNavigationBarAppearance) {
        self.standardAppearance = value.standardAppearance
        self.scrollEdgeAppearance = value.scrollEdgeAppearance
    }
    
    /**
     SparrowKit: Appearance cases.
     */
    @available(iOS 13.0, tvOS 13.0, *)
    public enum SPNavigationBarAppearance {
        
        case transparentAlways
        case transparentStandardOnly
        case opaqueAlways
        
        public var standardAppearance: UINavigationBarAppearance {
            switch self {
            case .transparentAlways:
                let appearance = UINavigationBarAppearance()
                appearance.configureWithTransparentBackground()
                return appearance
            case .transparentStandardOnly:
                let appearance = UINavigationBarAppearance()
                appearance.configureWithDefaultBackground()
                return appearance
            case .opaqueAlways:
                let appearance = UINavigationBarAppearance()
                appearance.configureWithDefaultBackground()
                return appearance
            }
        }
        
        public var scrollEdgeAppearance: UINavigationBarAppearance {
            switch self {
            case .transparentAlways:
                let appearance = UINavigationBarAppearance()
                appearance.configureWithTransparentBackground()
                return appearance
            case .transparentStandardOnly:
                let appearance = UINavigationBarAppearance()
                appearance.configureWithTransparentBackground()
                return appearance
            case .opaqueAlways:
                let appearance = UINavigationBarAppearance()
                appearance.configureWithDefaultBackground()
                return appearance
            }
        }
    }
}
#endif
