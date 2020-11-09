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
    
    /**
     SparrowKit: This method sets the color scheme for a specific button state
     */
    open func setColorise(_ colorise: Colorise, for state: State) {
        switch state {
        case .default:
            defaultColorise = colorise
        case .dimmed:
            dimmedColorise = colorise
        case .disabled:
            disabledColorise = colorise
        }
        update()
    }
    
    /**
     SparrowKit: Set the color scheme for the default state.
     `.dimmed` and `.disabled` states calculate automaticaly
     */
    open func applyDefaultAppearance(with colorise: Colorise) {
        defaultColorise = colorise
        let dimmedBackground = colorise.background == .clear ? .clear : dimmedContentColor.alpha(0.1)
        dimmedColorise = Colorise(content: dimmedContentColor, background: dimmedBackground)
        disabledColorise = Colorise(content: dimmedContentColor, background: dimmedBackground)
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
     SparrowKit: Colors for default state.
     */
    private lazy var defaultColorise = Colorise(content: tintColor, background: .clear)
    
    /**
     SparrowKit: Colors for disabled state.
     */
    private lazy var disabledColorise = Colorise(content: dimmedContentColor, background: .clear)
    
    /**
     SparrowKit: Colors for dimmed mode.
     */
    private lazy var dimmedColorise = Colorise(content: dimmedContentColor, background: .clear)
    
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
    
    /**
     SparrowKit: Button state
     */
    public enum State {
        /// The button is in the normal state
        case `default`
        
        /// The button is in a dimmed state, for example when another `UIViewController` is presented
        case dimmed
        
        /// The button is disabled. Controlled through the `isDisabled` property
        case disabled
    }
}
#endif
