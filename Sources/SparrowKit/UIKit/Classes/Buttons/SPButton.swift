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
 SparrowKit: Basic Button class.
 
 It has one shared init `commonInit` which call for all default inits.
 
 - Note: For Russian-speaking developer available [tutorial about button insets]( https://sparrowcode.io/edge-insets-uibutton).
 */
open class SPButton: UIButton {
    
    // MARK: - Views
    
    internal var activityIndicatorView: UIActivityIndicatorView?
    
    // MARK: - Init
    
    public init() {
        super.init(frame: CGRect.zero)
        commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    /**
     SparrowKit: Wrapper of init.
     Called in each init and using for configuration.
     
     No need ovveride init. Using one function for configurate view.
     */
    open func commonInit() {}
    
    // MARK: - Public

    open func setLoading(_ state: Bool) {
        
        // Validate
        
        if state {
            if activityIndicatorView?.isAnimating ?? false { return }
        } else {
            if activityIndicatorView == nil { return }
        }
        
        // Process
        
        let contentViews = subviews
        
        if state {
            if activityIndicatorView == nil {
                let activityIndicatorView = UIActivityIndicatorView()
                addSubviews(activityIndicatorView)
                self.activityIndicatorView = activityIndicatorView
            }
            contentViews.forEach({ $0.isHidden = true })
            activityIndicatorView?.startAnimating()
            layoutSubviews()
        } else {
            contentViews.forEach({ $0.isHidden = false })
            activityIndicatorView?.stopAnimating()
            activityIndicatorView?.removeFromSuperview()
            activityIndicatorView = nil
        }
    }
    
    // MARK: - Layout
    
    /**
     SparrowKit: Inset between image and title.
     
     No need any additional processing layout.
     It work automatically in `layoutSubviews` method.
     */
    open var titleImageInset: CGFloat? = nil
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        activityIndicatorView?.setToCenter()
        
        if let inset = titleImageInset {
            if imageView?.image == nil {
                imageEdgeInsets.right = 0
                titleEdgeInsets.left = 0
            } else {
                let direction = UIView.userInterfaceLayoutDirection(for: semanticContentAttribute)
                if direction == .leftToRight {
                    imageEdgeInsets.right = inset
                    titleEdgeInsets.left = inset
                } else {
                    imageEdgeInsets.right = -inset
                    titleEdgeInsets.left = -inset
                }
            }
        }
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        var superSize = super.sizeThatFits(size)
        if let titleImageInset = titleImageInset {
            superSize.width += titleImageInset
        }
        return superSize
    }
}
#endif
