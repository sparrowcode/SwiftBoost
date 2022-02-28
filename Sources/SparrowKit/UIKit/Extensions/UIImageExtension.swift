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

#if canImport(UIKit)

import UIKit

extension UIImage {
    
    // MARK: - Init
    
    /**
     SparrowKit: Create new `UIImage` object by color and size.
     
     Create filled image with specific color.
     
     - parameter color: Color.
     - parameter size: Size.
     */
    public convenience init(color: UIColor, size: CGSize) {
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
    
    /**
     SparrowKit: Create `SFSymbols` image.
     
     - parameter name: Name of system image..
     */
    @available(iOS 13, tvOS 13, *)
    public static func system(_ name: String) -> UIImage {
        return UIImage.init(systemName: name) ?? UIImage()
    }
    
    /**
     SparrowKit: Create `SFSymbols` image with specific configuration.
     
     - parameter name: Name of system image.
     - parameter pointSize: Font size of image.
     - parameter weight: Weight of font of image.
     */
    @available(iOS 13, tvOS 13, *)
    public static func system(_ name: String, pointSize: CGFloat, weight: UIImage.SymbolWeight) -> UIImage {
        let configuration = UIImage.SymbolConfiguration(pointSize: pointSize, weight: weight)
        return UIImage(systemName: name, withConfiguration: configuration) ?? UIImage()
    }
    
    /**
     SparrowKit: Create `SFSymbols` image with specific configuration.
     
     - parameter name: Name of system image.
     - parameter font: Font  of image.
     */
    @available(iOS 13, tvOS 13, *)
    public static func system(_ name: String, font: UIFont) -> UIImage {
        let configuration = UIImage.SymbolConfiguration(font: font)
        return UIImage(systemName: name, withConfiguration: configuration) ?? UIImage()
    }
    
    #if os(iOS)
    /**
     SparrowKit: For iOS version get fill image, for macOS get lines images.
     
     - parameter name: Name of system image.
     */
    @available(iOS 13.0, *)
    public static func adaptive(_ name: String) -> UIImage {
        var formattedName = name
        let fillSuffix = ".fill"
        if UIDevice.current.isMac {
            if name.hasSuffix(fillSuffix) {
                formattedName = name.removedSuffix(fillSuffix)
            }
        } else {
            if !name.hasSuffix(fillSuffix) {
                formattedName = name + fillSuffix
            }
        }
        let image = UIImage.init(systemName: formattedName)
        return image ?? UIImage.system(name)
    }
    #endif
    
    // MARK: - Helpers
    
    /**
     SparrowKit: Get size of image in bytes.
     */
    open var bytesSize: Int {
        return jpegData(compressionQuality: 1)?.count ?? 0
    }
    
    /**
     SparrowKit: Get size of image in kilibytes.
     */
    open var kilobytesSize: Int {
        return (jpegData(compressionQuality: 1)?.count ?? 0) / 1024
    }
    
    /**
     SparrowKit: Compress image.
     
     - parameter quality: Factor of compress. Can be in 0...1.
     */
    open func compresse(quality: CGFloat = 0.5) -> UIImage? {
        guard let data = jpegData(compressionQuality: quality) else { return nil }
        return UIImage(data: data)
    }
    
    /**
     SparrowKit: Compress data of image.
     
     - parameter quality: Factor of compress. Can be in 0...1.
     */
    open func compressedData(quality: CGFloat = 0.5) -> Data? {
        return jpegData(compressionQuality: quality)
    }
    
    // MARK: - Appearance
    
    /**
     SparrowKit: Always original render mode.
     */
    open var alwaysOriginal: UIImage {
        return withRenderingMode(.alwaysOriginal)
    }
    
    /**
     SparrowKit: Always original render mode.
     
     - parameter color: Color of image.
     */
    @available(iOS 13.0, tvOS 13.0, *)
    open func alwaysOriginal(with color: UIColor) -> UIImage {
        return withTintColor(color, renderingMode: .alwaysOriginal)
    }
    
    /**
     SparrowKit: Always template render mode.
     */
    open var alwaysTemplate: UIImage {
        return withRenderingMode(.alwaysTemplate)
    }
    
    /**
     SparrowKit: Get average color of image.
     */
    #if canImport(CoreImage)
    open func averageColor() -> UIColor? {
        guard let ciImage = ciImage ?? CIImage(image: self) else { return nil }
        let parameters = [kCIInputImageKey: ciImage, kCIInputExtentKey: CIVector(cgRect: ciImage.extent)]
        guard let outputImage = CIFilter(name: "CIAreaAverage", parameters: parameters)?.outputImage else {
            return nil
        }
        var bitmap = [UInt8](repeating: 0, count: 4)
        let workingColorSpace: Any = cgImage?.colorSpace ?? NSNull()
        let context = CIContext(options: [.workingColorSpace: workingColorSpace])
        context.render(outputImage,
                       toBitmap: &bitmap,
                       rowBytes: 4,
                       bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                       format: .RGBA8,
                       colorSpace: nil)
        return UIColor(red: CGFloat(bitmap[0]) / 255.0,
                       green: CGFloat(bitmap[1]) / 255.0,
                       blue: CGFloat(bitmap[2]) / 255.0,
                       alpha: CGFloat(bitmap[3]) / 255.0)
    }
    
    /**
     SparrowKit: Resize image to new size with save proportional.
     */
    open func resize(newWidth desiredWidth: CGFloat) -> UIImage {
        let oldWidth = size.width
        let scaleFactor = desiredWidth / oldWidth
        let newHeight = size.height * scaleFactor
        let newWidth = oldWidth * scaleFactor
        let newSize = CGSize(width: newWidth, height: newHeight)
        return resize(targetSize: newSize)
    }

    /**
     SparrowKit: Resize image to new size with save proportional.
     */
    open func resize(newHeight desiredHeight: CGFloat) -> UIImage {
        let scaleFactor = desiredHeight / size.height
        let newWidth = size.width * scaleFactor
        let newSize = CGSize(width: newWidth, height: desiredHeight)
        return resize(targetSize: newSize)
    }
    
    /**
     SparrowKit: Resize image to new size without saving proportional.
     */
    open func resize(targetSize: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size:targetSize).image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
    #endif
}

#endif
