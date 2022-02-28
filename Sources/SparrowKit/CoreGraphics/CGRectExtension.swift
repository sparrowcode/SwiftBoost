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
import CoreGraphics

public extension CGRect {
    
    /**
     SparrowKit: Change `maxX` position.
     
     - parameter value: New `maxX` position.
     */
    mutating func setMaxX(_ value: CGFloat) {
        origin.x = value - width
    }
    
    /**
     SparrowKit: Change `maxY` position.
     
     - parameter value: New `maxY` position.
     */
    mutating func setMaxY(_ value: CGFloat) {
        origin.y = value - height
    }
    
    /**
     SparrowKit: Change `width` without change other coordinates.
     
     - parameter width: New `width`.
     */
    mutating func setWidth(_ width: CGFloat) {
        if width == self.width { return }
        self = CGRect.init(x: origin.x, y: origin.y, width: width, height: height)
    }
    
    /**
     SparrowKit: Change `height` without change other coordinates.
     
     - parameter height: New `height`.
     */
    mutating func setHeight(_ height: CGFloat) {
        if height == self.height { return }
        self = CGRect.init(x: origin.x, y: origin.y, width: width, height: height)
    }
    
    /**
     SparrowKit: Change `width` & `height` without change other coordinates.
     
     - parameter width: New `width`.
     - parameter height: New `height`.
     */
    mutating func setWidth(_ width: CGFloat, height: CGFloat) {
        if width == self.width && height == self.height { return }
        self = CGRect.init(x: origin.x, y: origin.y, width: width, height: height)
    }
    
    // MARK: - Init
    
    /**
     SparrowKit: Create new frame.
     
     - parameter center: `center` position.
     - parameter size: New side sizes.
     */
    init(center: CGPoint, size: CGSize) {
        let origin = CGPoint(x: center.x - size.width / 2.0, y: center.y - size.height / 2.0)
        self.init(origin: origin, size: size)
    }
    
    /**
     SparrowKit: Create new frame.
     
     - parameter x: `x` position.
     - parameter maxY: `maxY` position.
     - parameter width: New `width`.
     - parameter height: New  `height`.
     */
    init(x: CGFloat, maxY: CGFloat, width: CGFloat, height: CGFloat) {
        self.init(x: x, y: 0, width: width, height: height)
        setMaxY(maxY)
    }
    
    /**
     SparrowKit: Create new frame.
     
     - parameter maxX: `maxX` position.
     - parameter y: `y` position.
     - parameter width: New `width`.
     - parameter height: New  `height`.
     */
    init(maxX: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        self.init(x: 0, y: y, width: width, height: height)
        setMaxX(maxX)
    }

    /**
     SparrowKit: Create new frame.
     
     - parameter maxX: `maxX` position.
     - parameter maxY: `maxY` position.
     - parameter width: New `width`.
     - parameter height: New  `height`.
     */
    init(maxX: CGFloat, maxY: CGFloat, width: CGFloat, height: CGFloat) {
        self.init(x: 0, y: 0, width: width, height: height)
        setMaxX(maxX)
        setMaxY(maxY)
    }
    
    /**
     SparrowKit: Create new frame.
     
     - parameter x: `x` position.
     - parameter y: `y` position.
     - parameter side: Same `width` and `height`.
     */
    init(x: CGFloat, y: CGFloat, side: CGFloat) {
        self.init(x: x, y: y, width: side, height: side)
    }
    
    /**
     SparrowKit: Create new frame.
     
     - parameter side: Same `width` and `height`.
     */
    init(side: CGFloat) {
        self.init(x: 0, y: 0, width: side, height: side)
    }
}
#endif
