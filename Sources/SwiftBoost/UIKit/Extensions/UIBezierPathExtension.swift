#if canImport(UIKit) && (os(iOS) || os(tvOS))
import UIKit

public extension UIBezierPath {
    
    convenience init(from: CGPoint, to otherPoint: CGPoint) {
        self.init()
        move(to: from)
        addLine(to: otherPoint)
    }
    
    convenience init(points: [CGPoint]) {
        self.init()
        if !points.isEmpty {
            move(to: points[0])
            for point in points[1...] {
                addLine(to: point)
            }
        }
    }
}
#endif
