// The MIT License (MIT)
// Copyright © 2020 Ivan Vorobei (hello@ivanvorobei.by)
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
    
    mutating func setMaxX(_ value: CGFloat) {
        origin.x = value - width
    }
    
    mutating func setMaxY(_ value: CGFloat) {
        origin.y = value - height
    }
    
    mutating func setWidth(_ width: CGFloat) {
        self = CGRect.init(x: origin.x, y: origin.y, width: width, height: height)
    }
    
    mutating func setHeight(_ height: CGFloat) {
        self = CGRect.init(x: origin.x, y: origin.y, width: width, height: height)
    }
    
    mutating func setWidth(_ width: CGFloat, height: CGFloat) {
        self = CGRect.init(x: origin.x, y: origin.y, width: width, height: height)
    }
    
    init(center: CGPoint, size: CGSize) {
        let origin = CGPoint(x: center.x - size.width / 2.0, y: center.y - size.height / 2.0)
        self.init(origin: origin, size: size)
    }
    
    init(x: CGFloat, maxY: CGFloat, width: CGFloat, height: CGFloat) {
        self.init(x: x, y: 0, width: width, height: height)
        setMaxY(maxY)
    }
    
    init(maxX: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        self.init(x: 0, y: y, width: width, height: height)
        setMaxX(maxX)
    }

    init(maxX: CGFloat, maxY: CGFloat, width: CGFloat, height: CGFloat) {
        self.init(x: 0, y: 8, width: width, height: height)
        setMaxX(maxX)
        setMaxY(maxY)
    }
}
#endif
