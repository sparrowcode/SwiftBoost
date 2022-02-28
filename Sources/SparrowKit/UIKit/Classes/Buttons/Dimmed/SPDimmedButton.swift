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
 SparrowKit: Button with process dimmed colors.
 
 Button support color states like `basic`, `dimmed` and `disabled`.
 For change it using `Colorise` object.
 
 Also available tinting for all modes.
 */
open class SPDimmedButton: SPButton {
    
    open override var isHighlighted: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    open override var isEnabled: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    open override func tintColorDidChange() {
        super.tintColorDidChange()
        updateAppearance()
    }
    
    /**
     SparrowKit: Higlight style when button pressing.
     
     If set content, only label and image change opacity.
     If choosed background, area of button will change opacity.
     */
    open var higlightStyle = HiglightStyle.default
    
    // MARK: - Colorises
    
    /**
     SparrowKit: Colorise for default state.
     */
    private lazy var defaultColorise = Colorise(content: tintColor, background: .clear)
    
    /**
     SparrowKit: Colorise for disabled state.
     */
    private lazy var disabledColorise = Colorise(content: .dimmedContent, background: .clear)
    
    /**
     SparrowKit: Colorise for dimmed state.
     */
    private lazy var dimmedColorise = Colorise(content: .dimmedContent, background: .clear)
    
    // MARK: - Data
    
    /**
     SparrowKit: Opacity of elements when button higlight.
     */
    open var highlightOpacity: CGFloat = 0.7
    
    // MARK: - Process
    
    /**
     SparrowKit: This method sets the color scheme for a specific button state
     */
    open func setColorise(_ colorise: Colorise, for state: AppearanceState) {
        switch state {
        case .default:
            defaultColorise = colorise
        case .dimmed:
            dimmedColorise = colorise
        case .disabled:
            disabledColorise = colorise
        }
        updateAppearance()
    }
    
    /**
     SparrowKit: Get colorise for specific state.
     */
    open func getColorise(for state: AppearanceState) -> Colorise {
        switch state {
        case .default:
            return defaultColorise
        case .dimmed:
            return dimmedColorise
        case .disabled:
            return disabledColorise
        }
    }
    
    /**
     SparrowKit: Set the color scheme for the default state.
     `.dimmed` and `.disabled` states calculate automaticaly.
     */
    open func applyDefaultAppearance(with colorise: Colorise? = nil) {
        defaultColorise = colorise ?? Colorise(content: .tint, background: .custom(.clear))
        let defaultBackgroundColor = colorFromColoriseMode(defaultColorise.background)
        let dimmedBackground = (defaultBackgroundColor == .clear) ? UIColor.clear : .dimmedBackground
        dimmedColorise = Colorise(content: .dimmedContent, background: dimmedBackground)
        disabledColorise = Colorise(content: .dimmedContent, background: dimmedBackground)
        updateAppearance()
    }
    
    /**
     SparrowKit: Update colors for current state.
     */
    private func updateAppearance() {
        if tintAdjustmentMode == .dimmed {
            applyColorise(dimmedColorise)
        } else if isEnabled {
            let colorise = self.defaultColorise
            applyColorise(colorise)
            
            // Image Tint Color
            var imageTintColor = colorFromColoriseMode(colorise.icon)
            imageTintColor = imageTintColor.withAlphaComponent(isHighlighted ? imageTintColor.alpha * highlightOpacity : imageTintColor.alpha)
            imageView?.tintColor = imageTintColor
            
            // Higlight
            switch higlightStyle {
            case .content:
                break
                // Content work life default.
                // For now no need specific process.
                // Leave for future.
                // for view in [imageView, titleLabel] { view?.alpha = isHighlighted ? highlightOpacity : 1 }
            case .background:
                let color = colorFromColoriseMode(colorise.background)
                backgroundColor = color.alpha(isHighlighted ? color.alpha * highlightOpacity : color.alpha)
            }
        } else {
            applyColorise(disabledColorise)
        }
    }
    
    /**
     SparrowKit: Apply colors from special colorise.
     */
    private func applyColorise(_ colorise: Colorise) {
        let titleColor = colorFromColoriseMode(colorise.title)
        setTitleColor(titleColor, for: .normal)
        setTitleColor(titleColor.withAlphaComponent(highlightOpacity), for: .highlighted)
        imageView?.tintColor = colorFromColoriseMode(colorise.icon)
        backgroundColor = colorFromColoriseMode(colorise.background)
    }
    
    /**
     SparrowKit: Get valid color by `Colorise.Mode` for this button.
     
     For example each call can return diffrent color for if changing tint.
     If mode in custom always return this value.
     
     - parameter mode: Colorise mode from which need get color.
     */
    public func colorFromColoriseMode(_ mode: Colorise.Mode) -> UIColor {
        switch mode {
        case .tint: return self.tintColor
        case .secondaryTint: return self.tintColor.secondary
        case .custom(let color): return color
        }
    }
}
#endif
