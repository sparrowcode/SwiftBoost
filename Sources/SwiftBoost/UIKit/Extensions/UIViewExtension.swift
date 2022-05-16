#if canImport(UIKit) && (os(iOS) || os(tvOS))
import UIKit

public extension UIView {
    
    convenience init(backgroundColor color: UIColor) {
        self.init()
        backgroundColor = color
    }
    
    var viewController: UIViewController? {
        weak var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    func addSubviews(_ subviews: [UIView]) { subviews.forEach { addSubview($0) } }
    func addSubviews(_ subviews: UIView...) { subviews.forEach { addSubview($0) } }
    func removeSubviews() { subviews.forEach { $0.removeFromSuperview() } }
    
    var hasSuperview: Bool { superview != nil }
    
    var screenshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    // MARK: - Layout
    
    var ltr: Bool { effectiveUserInterfaceLayoutDirection == .leftToRight }
    var rtl: Bool { effectiveUserInterfaceLayoutDirection == .rightToLeft }
    
    func setEqualSuperviewBoundsWithFrames() {
        guard let superview = self.superview else { return }
        if frame != superview.bounds {
            frame = superview.bounds
        }
    }
    
    func setEqualSuperviewBoundsWithAutoresizingMask() {
        guard let superview = self.superview else { return }
        if frame != superview.bounds {
            frame = superview.bounds
        }
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func setEqualSuperviewBoundsWithAutoLayout() {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leftAnchor.constraint(equalTo: superview.leftAnchor),
            rightAnchor.constraint(equalTo: superview.rightAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
    
    func setEqualSuperviewMarginsWithFrames() {
        guard let superview = self.superview else { return }
        frame = .init(x: superview.layoutMargins.left, y: superview.layoutMargins.top, width: superview.layoutWidth, height: superview.layoutHeight)
    }
    
    func setEqualSuperviewMarginsWithAutoLayout() {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor),
            leftAnchor.constraint(equalTo: superview.layoutMarginsGuide.leftAnchor),
            rightAnchor.constraint(equalTo: superview.layoutMarginsGuide.rightAnchor),
            bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    
    func setWidthAndFit(width: CGFloat) {
        frame.setWidth(width)
        sizeToFit()
    }
    
    func setXToSuperviewLeftMargin() {
        guard let superview = self.superview else { return }
        frame.origin.x = superview.layoutMargins.left
    }
    
    func setMaxXToSuperviewRightMargin() {
        guard let superview = self.superview else { return }
        frame.setMaxX(superview.frame.width - superview.layoutMargins.right)
    }
    
    func setMaxYToSuperviewBottomMargin() {
        guard let superview = self.superview else { return }
        frame.setMaxY(superview.frame.height - superview.layoutMargins.bottom)
    }
    
    func setXCenter() { center.x = (superview?.frame.width ?? .zero) / 2 }
    func setYCenter() { center.y = (superview?.frame.height ?? .zero) / 2 }
    
    func setToCenter() {
        setXCenter()
        setYCenter()
    }
    
    // MARK: Readable Content Guide
    
    var readableMargins: UIEdgeInsets {
        let layoutFrame = readableContentGuide.layoutFrame
        return UIEdgeInsets(
            top: layoutFrame.origin.y,
            left: layoutFrame.origin.x,
            bottom: frame.height - layoutFrame.height - layoutFrame.origin.y,
            right: frame.width - layoutFrame.width - layoutFrame.origin.x
        )
    }
    
    var readableWidth: CGFloat { readableContentGuide.layoutFrame.width }
    var readableHeight: CGFloat { readableContentGuide.layoutFrame.height }
    
    var readableFrame: CGRect {
        let margins = readableMargins
        return CGRect.init(x: margins.left, y: margins.top, width: readableWidth, height: readableHeight)
    }
    
    // MARK: Layout Margins Guide
    
    var layoutWidth: CGFloat { frame.width - layoutMargins.left - layoutMargins.right }
    var layoutHeight: CGFloat { frame.height - layoutMargins.top - layoutMargins.bottom }
    var layoutFrame: CGRect { CGRect.init(x: layoutMargins.left, y: layoutMargins.top, width: layoutWidth, height: layoutHeight) }
    
    func setSafeLayoutMargins(_ value: UIEdgeInsets) {
        if layoutMargins != value {
            layoutMargins = value
        }
    }
    
    // MARK: - Appearance
    
    var masksToBounds: Bool {
        get { layer.masksToBounds }
        set { layer.masksToBounds = newValue }
    }
    
    func roundCorners(_ corners: CACornerMask = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner], curve: CALayerCornerCurve = .continuous, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = corners
        layer.cornerCurve = curve
    }
    
    func roundMinimumSide() {
        roundCorners(radius: min(frame.width / 2, frame.height / 2))
    }
    
    var borderColor: UIColor? {
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
    
    var borderWidth: CGFloat {
        get { layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    func addShadow(ofColor color: UIColor, radius: CGFloat, offset: CGSize, opacity: Float) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    
    func addParalax(amount: CGFloat) {
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
    
    func removeParalax() {
        motionEffects.removeAll()
    }
}
#endif
