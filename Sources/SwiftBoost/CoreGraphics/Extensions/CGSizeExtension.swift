#if canImport(CoreGraphics)
import CoreGraphics

public extension CGSize {
    
    init(side: CGFloat) {
        self.init(width: side, height: side)
    }

    var aspectRatio: CGFloat {
        guard width != .zero, height != .zero else { return .zero }
        return width / height
    }
    
    var maxDimension: CGFloat { max(width, height) }
    var minDimension: CGFloat { min(width, height) }
}
#endif
