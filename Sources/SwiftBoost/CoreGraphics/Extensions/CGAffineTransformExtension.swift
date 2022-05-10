#if canImport(CoreGraphics)
import CoreGraphics

public extension CGAffineTransform {
    
    init(scale: CGFloat) {
        self.init(scaleX: scale, y: scale)
    }
}
#endif
