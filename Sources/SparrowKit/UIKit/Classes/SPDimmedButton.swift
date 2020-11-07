// The MIT License (MIT)
// Copyright © 2020 Ivan Varabei (varabeis@icloud.com)
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

open class SPDimmedButton: SPButton {
    
    // MARK: - Ovveride
    
    open override var isHighlighted: Bool {
        didSet {
            update()
        }
    }
    
    open override var isEnabled: Bool {
        didSet {
            update()
        }
    }
    
    open override func tintColorDidChange() {
        super.tintColorDidChange()
        update()
    }
    
    // MARK: - Colorise
    
    /**
     SparrowKit: Colors for default state.
     */
    open lazy var defaultColorise = Colorise(content: tintColor, background: .clear)
    
    /**
     SparrowKit: Colors for disabled state.
     */
    open lazy var disabledColorise = Colorise(content: tintColor, background: .clear)
    
    /**
     SparrowKit: Colors for dimmed mode.
     */
    open lazy var dimmedColorise = Colorise(content: dimmedContentColor, background: .clear)
    
    /**
     SparrowKit: If button has area background,
     you can set dimmed and disabled modes with call it func.
     */
    open func applyStylesIfArea() {
        dimmedColorise = Colorise(content: dimmedContentColor, background: dimmedContentColor.withAlphaComponent(0.1))
        disabledColorise = Colorise(content: dimmedContentColor, background: dimmedContentColor.withAlphaComponent(0.1))
        update()
    }
    
    /**
     SparrowKit: Update colors for current state.
     */
    open func update() {
        if tintAdjustmentMode == .dimmed {
            apply(dimmedColorise)
        } else if isEnabled {
            apply(defaultColorise)
            let imageTintColor = defaultColorise.icon.withAlphaComponent(isHighlighted ? highlightOpacity : 1)
            imageView?.tintColor = imageTintColor
        } else {
            apply(disabledColorise)
        }
    }
    
    /**
     SparrowKit: Apply colors.
     */
    private func apply(_ colorise: Colorise) {
        setTitleColor(colorise.title, for: .normal)
        setTitleColor(colorise.title.withAlphaComponent(highlightOpacity), for: .highlighted)
        imageView?.tintColor = colorise.icon
        backgroundColor = colorise.background
    }
    
    // MARK: - Data
    
    /**
     SparrowKit: Opacity of elements when button higlight.
     */
    open var highlightOpacity: CGFloat = 0.7
    
    private var dimmedContentColor: UIColor {
        if #available(iOS 13, tvOS 13, *) {
            return UIColor.secondaryLabel
        } else {
           return UIColor(hex: "3c3c4399")
        }
    }
    
    // MARK: - Models
    
    /**
     SparrowKit: Represent colors for state of button for elements.
     */
    public struct Colorise {
        
        var title: UIColor
        var icon: UIColor
        var background: UIColor
        
        /**
         - parameter content: Color for `title` & `icon`
         - parameter background: Color for background
         */
        public init(content: UIColor, background: UIColor) {
            self.title = content
            self.icon = content
            self.background = background
        }
    }
}
#endif
