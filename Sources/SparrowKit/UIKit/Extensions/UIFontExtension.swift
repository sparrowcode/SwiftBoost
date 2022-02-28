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

public extension UIFont {
    
    /**
     SparrowKit: Convert font to rounded design.
     */
    var rounded: UIFont {
        if #available(iOS 13, tvOS 13, *) {
            guard let descriptor = fontDescriptor.withDesign(.rounded) else { return self }
            return UIFont(descriptor: descriptor, size: 0)
        } else {
            return self
        }
        
    }
    
    /**
     SparrowKit: Convert font to monospaced design.
     */
    var monospaced: UIFont {
        if #available(iOS 13, tvOS 13, *) {
            guard let descriptor = fontDescriptor.withDesign(.monospaced) else { return self }
            return UIFont(descriptor: descriptor, size: 0)
        } else {
            return self
        }
    }
    
    /**
     SparrowKit: Convert font to serif design.
     */
    var serif: UIFont {
        if #available(iOS 13, tvOS 13, *) {
            guard let descriptor = fontDescriptor.withDesign(.serif) else { return self }
            return UIFont(descriptor: descriptor, size: 0)
        } else {
            return self
        }
    }
    
    /**
     SparrowKit: Get font by text style and correction.
     
     If you not apply correction, you get system size of font.
     
     - parameter style: Text style for which need font size.
     - parameter addPoints: Correction of size font.
     */
    static func preferredFont(forTextStyle style: TextStyle, addPoints: CGFloat = 0) -> UIFont {
        let referensFont = UIFont.preferredFont(forTextStyle: style)
        return referensFont.withSize(referensFont.pointSize + addPoints)
    }
    
    /**
     SparrowKit: Get font by text style and correction. With custom font weight.
     
     If you not apply correction, you get system size of font.
     
     - parameter style: Text style for which need font size.
     - parameter weight: Custom weight of font.
     - parameter addPoints: Correction of size font.
     */
    static func preferredFont(forTextStyle style: TextStyle, weight: Weight, addPoints: CGFloat = 0) -> UIFont {
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        let font = UIFont.systemFont(ofSize: descriptor.pointSize + addPoints, weight: weight)
        let metrics = UIFontMetrics(forTextStyle: style)
        return metrics.scaledFont(for: font)
    }
}

#endif
