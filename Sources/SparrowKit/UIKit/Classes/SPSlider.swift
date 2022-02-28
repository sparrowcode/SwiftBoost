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
 SparrowKit: Basic Slider class.
 
 It has one shared init `commonInit` which call for all default inits.
 */
open class SPSlider: UISlider {
    
    /**
     SparrowKit: Minimum label.
     */
    open lazy var minimumTrackLabel: SPLabel = createTrackLabel()
    
    /**
     SparrowKit: Maximum label.
     */
    open lazy var maximumTrackLabel: SPLabel = createTrackLabel()
    
    /**
     SparrowKit: Generator of labels.
     */
    private func createTrackLabel() -> SPLabel {
        let label = SPLabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.textAlignment = .center
        if #available(iOS 13.0, *) {
            label.textColor = .secondaryLabel
        } else {
            label.textColor = .gray
        }
        addSubview(label)
        return label
    }
    
    /**
     SparrowKit: Fixed size of minimum track label.
     If `nil` label using size to fit for get width.
     */
    open var minimumTrackLabelWidth: CGFloat? = nil
    
    /**
     SparrowKit: Fixed size of maximum track label.
     If `nil` label using size to fit for get width.
     */
    open var maximumTrackLabelWidth: CGFloat? = nil
    
    // MARK: - Init
    
    public init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    /**
     SparrowKit: Wrapper of init.
     Called in each init and using for configuration.
     
     No need ovveride init. Using one function for configurate view.
     */
    open func commonInit() {}
    
    // MARK: - Layout
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        minimumTrackLabel.sizeToFit()
        if let minimumTrackLabelWidth = self.minimumTrackLabelWidth {
            minimumTrackLabel.frame.setWidth(minimumTrackLabelWidth)
        }
        minimumTrackLabel.frame.origin.x = 0
        minimumTrackLabel.setYCenter()
        
        maximumTrackLabel.sizeToFit()
        if let maximumTrackLabelWidth = self.maximumTrackLabelWidth {
            maximumTrackLabel.frame.setWidth(maximumTrackLabelWidth)
        }
        maximumTrackLabel.frame.setMaxX(frame.width)
        maximumTrackLabel.setYCenter()
    }
    
    open override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.trackRect(forBounds: bounds)
        guard minimumTrackLabel.text != nil && maximumTrackLabel.text != nil else { return superRect }
        
        let leftTrackLabelWidth = minimumTrackLabel.frame.width
        let rightTrackLabelWidth = maximumTrackLabel.frame.width
        let space: CGFloat = 10
        return CGRect.init(x: superRect.origin.x + leftTrackLabelWidth + space, y: superRect.origin.y, width: superRect.width - leftTrackLabelWidth - rightTrackLabelWidth - space * 2, height: superRect.height)
    }
}
#endif
