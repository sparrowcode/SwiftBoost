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
 SparrowKit: Basic Table View Cell class.
 
 It has one shared init `commonInit` which call for all default inits.
 */
open class SPTableViewCell: UITableViewCell {
    
    /**
     SparrowKit: Storage `IndexPath`.
     
     Value available only if you configure it before. Useful using with threads.
     Reusable system of table can take some bugs without compared valid index path.
     */
    open var currentIndexPath: IndexPath?
    
    /**
     SparrowKit: Wrapper if selection color in `selectedBackgroundView`.
     
     By default `selectedBackgroundView` not inited, but this class init it before and view is ready.
     */
    open var selectedColor: UIColor = .clear {
        didSet {
            selectedBackgroundView?.backgroundColor = selectedColor
        }
    }
    
    /**
     SparrowKit: Next level of selection style. Manage changes when cell higlighted.
     
     With it changes also changing `.selectionStyle`.
     */
    open var higlightStyle: HiglightStyle = .none {
        didSet {
            self.selectionStyle = self.higlightStyle.selectionStyle
        }
    }
    
    // MARK: - Views
    
    internal var activityIndicatorView: UIActivityIndicatorView?
    
    // MARK: - Init
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    /**
     SparrowKit: Wrapper of init.
     Called in each init and using for configuration.
     
     No need ovveride other init. Using one function for configurate view.
     */
    open func commonInit() {}
    
    // MARK: - Lifecycle
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        currentIndexPath = nil
        setLoading(false)
    }
    
    open override func tintColorDidChange() {
        super.tintColorDidChange()
        if #available(iOS 13.0, *) {
            #if os(iOS)
            selectedColor = UIColor.init(
                // For light always good .systemGray5
                light: .systemGray5,
                // For dark some cases may have same color like background.
                dark: backgroundColor?.mixWithColor(.white, amount: 0.06) ?? .systemGray4
            )
            #endif
        }
    }
    
    open override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        let higlightContent = (higlightStyle == .content)
        if higlightContent {
            contentView.subviews.forEach({ $0.alpha = highlighted ? 0.6 : 1 })
            // [imageView, textLabel, detailTextLabel].forEach({ $0?.alpha = highlighted ? 0.6 : 1 })
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicatorView?.setToCenter()
    }
    
    // MARK: - Public

    open func setLoading(_ state: Bool) {
        
        // Validate
        
        if state {
            if activityIndicatorView?.isAnimating ?? false { return }
        } else {
            if activityIndicatorView == nil { return }
        }
        
        // Process
        
        let contentViews = contentView.subviews
        
        if state {
            if activityIndicatorView == nil {
                let activityIndicatorView = UIActivityIndicatorView()
                contentView.addSubviews(activityIndicatorView)
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
    
    // MARK: - Models
    
    /**
     SparrowKit: Next level of selection style. Manage changes when cell higlighted.
     */
    public enum HiglightStyle {
        
        case none
        case `default`
        case content
        
        public var selectionStyle: UITableViewCell.SelectionStyle {
            switch self {
            case .none: return .none
            case .`default`: return .`default`
            case .content: return .none
            }
        }
    }
}
#endif
