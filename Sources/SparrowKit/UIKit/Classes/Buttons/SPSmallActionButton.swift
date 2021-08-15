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
 SparrowKit: Small action button.
 Usually using at bottom of screen.
 */
open class SPSmallActionButton: SPDimmedButton {
    
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
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline, weight: .bold, addPoints: -1)
        titleLabel?.numberOfLines = 1
        titleImageInset = 6
        contentEdgeInsets = .init(horizontal: 10, vertical: .zero)
    }
    
    // MARK: - Public
    
    /**
     SparrowKit: Wrapper of set content and color of button.
     
     - parameter title: Text which using like title.
     - parameter icon: Object of `UIImage`, using like icon. Usually Apple doesn't use icon in this button.
     - parameter colorise: Color of button in default state.
     */
    public func set(title: String, icon: UIImage? = nil, colorise: SPDimmedButton.Colorise) {
        setTitle(title)
        if let icon = icon {
            setImage(icon.alwaysTemplate)
        }
        applyDefaultAppearance(with: colorise)
    }
    
    // MARK: - Layout
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        let superSize = super.sizeThatFits(size)
        var width = superSize.width
        if width < 70 { width = 70 }
        
        var height = superSize.height + 12
        if let titleLabel = titleLabel, let imageView = imageView, let _ = imageView.image {
            if titleLabel.frame.height > 0 && imageView.frame.height > 0 {
                let imageCorrection = imageView.frame.height - titleLabel.frame.height
                height -= imageCorrection
            }
        }
        
        return CGSize(width: width, height: height)
    }
    
    // MARK: - Ovveride
    
    open override var isHighlighted: Bool {
        didSet {
            switch higlightStyle {
            case .content:
                for view in [imageView, titleLabel] { view?.alpha = isHighlighted ? highlightOpacity : 1 }
            case .background:
                let color = backgroundColor
                backgroundColor = color?.withAlphaComponent(isHighlighted ? highlightOpacity : 1)
            }
        }
    }
    
    open override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title?.uppercased(), for: state)
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
