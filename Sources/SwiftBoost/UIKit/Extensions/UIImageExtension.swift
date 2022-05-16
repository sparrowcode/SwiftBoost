#if canImport(UIKit)
import UIKit

public extension UIImage {
    
    // MARK: - Init
    
    convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        defer {
            UIGraphicsEndImageContext()
        }
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        guard let aCgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            self.init()
            return
        }
        self.init(cgImage: aCgImage)
    }
    
    static func system(_ name: String) -> UIImage {
        return UIImage.init(systemName: name) ?? UIImage()
    }
    
    static func system(_ name: String, pointSize: CGFloat, weight: UIImage.SymbolWeight) -> UIImage {
        let configuration = UIImage.SymbolConfiguration(pointSize: pointSize, weight: weight)
        return UIImage(systemName: name, withConfiguration: configuration) ?? UIImage()
    }
    
    static func system(_ name: String, font: UIFont) -> UIImage {
        let configuration = UIImage.SymbolConfiguration(font: font)
        return UIImage(systemName: name, withConfiguration: configuration) ?? UIImage()
    }
    
    // MARK: - Helpers
    
    var bytesSize: Int { jpegData(compressionQuality: 1)?.count ?? .zero }
    var kilobytesSize: Int { (jpegData(compressionQuality: 1)?.count ?? .zero) / 1024 }
    
    func compresse(quality: CGFloat) -> UIImage? {
        guard let data = jpegData(compressionQuality: quality) else { return nil }
        return UIImage(data: data)
    }
    
    func compressedData(quality: CGFloat) -> Data? {
        return jpegData(compressionQuality: quality)
    }
    
    // MARK: - Appearance
    
    var alwaysTemplate: UIImage {
        return withRenderingMode(.alwaysTemplate)
    }
    
    var alwaysOriginal: UIImage {
        return withRenderingMode(.alwaysOriginal)
    }
    
    func alwaysOriginal(with color: UIColor) -> UIImage {
        return withTintColor(color, renderingMode: .alwaysOriginal)
    }
    
    #if canImport(CoreImage)
    func resize(newWidth desiredWidth: CGFloat) -> UIImage {
        let oldWidth = size.width
        let scaleFactor = desiredWidth / oldWidth
        let newHeight = size.height * scaleFactor
        let newWidth = oldWidth * scaleFactor
        let newSize = CGSize(width: newWidth, height: newHeight)
        return resize(targetSize: newSize)
    }
    
    func resize(newHeight desiredHeight: CGFloat) -> UIImage {
        let scaleFactor = desiredHeight / size.height
        let newWidth = size.width * scaleFactor
        let newSize = CGSize(width: newWidth, height: desiredHeight)
        return resize(targetSize: newSize)
    }
    
    func resize(targetSize: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size:targetSize).image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
    #endif
}
#endif
