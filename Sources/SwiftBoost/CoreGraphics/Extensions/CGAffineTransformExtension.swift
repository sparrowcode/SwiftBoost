#if canImport(CoreGraphics)
import CoreGraphics

public extension CGAffineTransform {
    
    init(scale: CGFloat) {
        self.init(scaleX: scale, y: scale)
    }
    
    init(rotationDegress: CGFloat) {
        self.init(rotationAngle: CGFloat(rotationDegress * .pi / 180))
    }
    
    func scaledBy(xy: CGFloat) -> CGAffineTransform {
        return self.scaledBy(x: xy, y: xy)
    }
    
    func rotated(degress: CGFloat) -> CGAffineTransform {
        return self.rotated(by: CGFloat(degress * .pi / 180))
    }
}
#endif
