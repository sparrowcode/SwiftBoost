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
    
    func resize(newWidth: CGFloat) -> CGSize {
        let scaleFactor = newWidth / self.width
        let newHeight = self.height * scaleFactor
        return CGSize(width: newWidth, height: newHeight)
    }
    
    func resize(newHeight: CGFloat) -> CGSize {
        let scaleFactor = newHeight / self.height
        let newWidth = self.width * scaleFactor
        return CGSize(width: newWidth, height: newHeight)
    }
}
#endif
