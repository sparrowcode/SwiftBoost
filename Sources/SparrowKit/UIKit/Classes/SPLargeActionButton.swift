// The MIT License (MIT)
// Copyright © 2020 Ivan Vorobei (hello@ivanvorobei.by)
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
 SparrowKit: Large action button.
 Usually using at bottom of screen.
 */
open class SPLargeActionButton: SPDimmedButton {
    
    // MARK: - Data
    
    /**
     SparrowKit: Higlight style when button pressing.
     
     If set content, only label and image change opacity.
     If choosed background, area of button will change opacity.
     */
    open var higlightStyle = HiglightStyle.default
    
    // MARK: - Init
    
    open override func commonInit() {
        super.commonInit()
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline, addPoints: 1)
        titleLabel?.numberOfLines = 1
        titleImageInset = 6
    }
    
    // MARK: - Public
    
    /**
     SparrowKit: Wrapper of set content and color of button.
     
     - parameter title: Text which using like title.
     - parameter icon: Object of `UIImage`, using like icon.
     - parameter colorise: Color of button in default state.
     */
    public func set(title: String, icon: UIImage?, colorise: SPDimmedButton.Colorise) {
        setTitle(title)
        if let icon = icon {
            setImage(icon.alwaysTemplate)
        }
        applyDefaultAppearance(with: colorise)
    }
    
    // MARK: - Layout
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(radius: 15)
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: size.width, height: 50)
    }
    
    // MARK: - Ovveride
    
    open override var isHighlighted: Bool {
        didSet {
            let higlightAlpha: CGFloat = 0.6
            switch higlightStyle {
            case .content:
                for view in [imageView, titleLabel] { view?.alpha = isHighlighted ? higlightAlpha : 1 }
            case .background:
                let color = backgroundColor
                backgroundColor = color?.withAlphaComponent(isHighlighted ? higlightAlpha : 1)
            }
        }
    }
    
    // MARK: - Models
    
    public enum HiglightStyle {
        
        case content
        case background
        
        static var `default`: HiglightStyle {
            return .background
        }
    }
}
#endif
