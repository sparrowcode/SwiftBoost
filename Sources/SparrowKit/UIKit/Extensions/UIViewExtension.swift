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

extension UIView {
    
    /**
     SparrowKit: Init `UIView` object with background color.
     
     - parameter backgroundColor: Color which using for background.
     */
    public convenience init(backgroundColor color: UIColor) {
        self.init()
        backgroundColor = color
    }
    
    // MARK: - Helpers
    
    /**
     SparrowKit: Get controller, on which place current view.
     
     - warning:
     If view not added to any controller, return nil.
     */
    open var viewController: UIViewController? {
        weak var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    /**
     SparrowKit: Add many subviews as array.
     
     - parameter subviews: Array of `UIView` objects.
     */
    open func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
    
    /**
     SparrowKit: Add many subviews as array.
     
     - parameter subviews: Array of `UIView` objects.
     */
    open func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
    
    /**
     SparrowKit: Remove all subviews.
     */
    open func removeSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    /**
     SparrowKit: State if current view has superview.
     */
    open var hasSuperview: Bool {
        superview != nil
    }
    
    /**
     SparrowKit: Take screenshoot of view as `UIImage`.
     */
    open var screenshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /**
     SparrowKit: If view has LTR interface.
     */
    open var ltr: Bool { effectiveUserInterfaceLayoutDirection == .leftToRight }
    
    /**
     SparrowKit: If view has TRL interface.
     */
    open var rtl: Bool { effectiveUserInterfaceLayoutDirection == .rightToLeft }
    
    // MARK: - Layout
    
    /**
     SparrowKit: Set specific width and after it fit view.
     
     - warning:
     Fit view can be return zero height. View shoud support it.
     */
    open func setWidthAndFit(width: CGFloat) {
        frame.setWidth(width)
        sizeToFit()
    }
    
    open func setXToSuperviewLeftMargin() {
        guard let superview = self.superview else { return }
        frame.origin.x = superview.layoutMargins.left
    }
    
    open func setMaxXToSuperviewRightMargin() {
        guard let superview = self.superview else { return }
        frame.setMaxX(superview.frame.width - superview.layoutMargins.right)
    }
    
    open func setMaxYToSuperviewBottomMargin() {
        guard let superview = self.superview else { return }
        frame.setMaxY(superview.frame.height - superview.layoutMargins.bottom)
    }
    
    /**
     SparrowKit: Set center X of current view to medium width of superview.
     
     - warning:
     If current view have not superview, center X is set to zero.
     */
    open func setXCenter() {
        center.x = (superview?.frame.width ?? 0) / 2
    }
    
    /**
     SparrowKit: Set center Y of current view to medium height of superview.
     
     - warning:
     If current view have not superview, center Y is set to zero.
     */
    open func setYCenter() {
        center.y = (superview?.frame.height ?? 0) / 2
    }
    
    /**
     SparrowKit: Set center of current view to center of superview.
     
     - warning:
     If current view have not superview, center is set to zero.
     */
    open func setToCenter() {
        setXCenter()
        setYCenter()
    }
    
    // MARK: Readable Content Guide
    
    /**
     SparrowKit: Margins of readable frame.
     */
    open var readableMargins: UIEdgeInsets {
        let layoutFrame = readableContentGuide.layoutFrame
        return UIEdgeInsets(
            top: layoutFrame.origin.y,
            left: layoutFrame.origin.x,
            bottom: frame.height - layoutFrame.height - layoutFrame.origin.y,
            right: frame.width - layoutFrame.width - layoutFrame.origin.x
        )
    }
    
    /**
     SparrowKit: Readable width of current view without horizontal readable margins.
     */
    open var readableWidth: CGFloat {
        return readableContentGuide.layoutFrame.width
    }
    
    /**
     SparrowKit: Readable height of current view without vertical readable margins.
     */
    open var readableHeight: CGFloat {
        return readableContentGuide.layoutFrame.height
    }
    
    /**
     SparrowKit: Readable frame of current view without vertical and horizontal readable margins.
     */
    open var readableFrame: CGRect {
        let margins = readableMargins
        return CGRect.init(x: margins.left, y: margins.top, width: readableWidth, height: readableHeight)
    }
    
    // MARK: Layout Margins Guide
    
    /**
     SparrowKit: Width of current view without horizontal layout margins.
     */
    open var layoutWidth: CGFloat {
        // ver 1
        // Depricated becouse sometimes return invalid size
        // return layoutMarginsGuide.layoutFrame.width
        
        // ver 2
        return frame.width - layoutMargins.left - layoutMargins.right
    }
    
    /**
     SparrowKit: Height of current view without vertical layout margins.
     */
    open var layoutHeight: CGFloat {
        // ver 1
        // Depricated becouse sometimes return invalid size
        // return layoutMarginsGuide.layoutFrame.height
        
        // ver 2
        return frame.height - layoutMargins.top - layoutMargins.bottom
    }
    
    /**
     SparrowKit: Frame of current view without horizontal and vertical layout margins.
     */
    open var layoutFrame: CGRect {
        return CGRect.init(x: layoutMargins.left, y: layoutMargins.top, width: layoutWidth, height: layoutHeight)
    }
    
    /**
     SparrowKit: Set layout margins safety.
     
     If margins now same, ignoring it.
     
     - parameter value: New layout margins.
     */
    open func setLayoutMargins(_ value: UIEdgeInsets) {
        if self.layoutMargins != value {
            self.layoutMargins = value
        }
    }
    
    // MARK: - Manage Frames
    
    /**
     SparrowKit: Set view equal frame to superview frame via frames.
     
     - warning:
     If view not have superview, nothing happen.
     */
    open func setEqualSuperviewBounds() {
        guard let superview = self.superview else { return }
        if frame != superview.bounds {
            frame = superview.bounds
        }
    }
    
    /**
     SparrowKit: Set view equal frame to superview frame via `autoresizingMask`.
     
     - warning:
     If view not have superview, nothing happen.
     */
    open func setEqualSuperviewBoundsWithAutoresizingMask() {
        guard let superview = self.superview else { return }
        if frame != superview.bounds {
            frame = superview.bounds
        }
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    /**
     SparrowKit: Set view equal frame to superview frame via Auto Layout.
     
     - warning:
     If view not have superview, constraints will not be added.
     */
    open func setEqualSuperviewBoundsWithAutoLayout() {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leftAnchor.constraint(equalTo: superview.leftAnchor),
            rightAnchor.constraint(equalTo: superview.rightAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
    
    /**
     SparrowKit: Set view equal frame to superview frame exlude margins via Auto Layout.
     
     - warning:
     If view not have superview, constraints will not be added.
     */
    open func setEqualSuperviewMarginsWithAutoLayout() {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor),
            leftAnchor.constraint(equalTo: superview.layoutMarginsGuide.leftAnchor),
            rightAnchor.constraint(equalTo: superview.layoutMarginsGuide.rightAnchor),
            bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Appearance
    
    /**
     SparrowKit: Wrapper for layer property `masksToBounds`.
     */
    open var masksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
    
    /**
     SparrowKit: Round corners .
     
     - parameter corners: Case of `CACornerMask`. Which corners need to round.
     - parameter curve: Case of `CornerCurve`. Style of rounded corners.
     - parameter radius: Amount of radius.
     */
    open func roundCorners(_ corners: CACornerMask = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner], curve: CornerCurve = .continuous, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = corners
        
        if #available(iOS 13.0, tvOS 13.0, *) {
            layer.cornerCurve = curve.layerCornerCurve
        }
    }
    
    /**
     SparrowKit: Round side by minimum `height` or `width`.
     */
    open func roundMinimumSide() {
        roundCorners(radius: min(frame.width / 2, frame.height / 2))
    }
    
    /**
     SparrowKit: Wrapper for layer property `borderColor`.
     */
    open var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            // Fix React-Native conflict issue
            guard String(describing: type(of: color)) != "__NSCFType" else { return }
            layer.borderColor = color.cgColor
        }
    }
    
    /**
     SparrowKit: Wrapper for layer property `borderWidth`.
     */
    open var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /**
     SparrowKit: Add shadow.
     
     - parameter color: Color of shadow.
     - parameter radius: Blur radius of shadow.
     - parameter offset: Vertical and horizontal offset from center fro shadow.
     - parameter opacity: Alpha for shadow view.
     */
    open func addShadow(ofColor color: UIColor, radius: CGFloat, offset: CGSize, opacity: Float) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    
    /**
     SparrowKit: Add paralax. Depended by angle of device.
     Can be not work is user reduce motion on settins device.
     
     - parameter amount: Amount of paralax effect.
     */
    open func addParalax(amount: CGFloat) {
        motionEffects.removeAll()
        let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontal.minimumRelativeValue = -amount
        horizontal.maximumRelativeValue = amount
        
        let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        vertical.minimumRelativeValue = -amount
        vertical.maximumRelativeValue = amount
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontal, vertical]
        self.addMotionEffect(group)
    }
    
    /**
     SparrowKit: Remove paralax.
     */
    open func removeParalax() {
        motionEffects.removeAll()
    }
    
    /**
     SparrowKit: Appear view with fade in animation.
     
     - parameter duration: Duration of animation.
     - parameter completion: Completion when animation ended.
     */
    open func fadeIn(duration: TimeInterval = 0.3, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: .zero, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
            self.alpha = 1
        }, completion: completion)
    }
    
    /**
     SparrowKit: Hide view with fade out animation.
     
     - parameter duration: Duration of animation.
     - parameter completion: Completion when animation ended.
     */
    open func fadeOut(duration: TimeInterval = 0.3, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: .zero, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
            self.alpha = 0
        }, completion: completion)
    }
    
    // MARK: - Models
    
    public enum CornerCurve {
        
        case circle
        case continuous
        
        @available(iOS 13.0, tvOS 13.0, *)
        var layerCornerCurve: CALayerCornerCurve {
            switch self {
            case .circle: return .circular
            case .continuous: return .continuous
            }
        }
    }
}
#endif

