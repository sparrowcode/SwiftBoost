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

public extension CGSize {
    
    /**
     SparrowKit: New size with same sides.
     
     Create `CGSize` with same `width` and `height`.
     
     - parameter side: `width` and `height`.
     */
    init(side: CGFloat) {
        self.init(width: side, height: side)
    }
    
    /**
     SparrowKit: Aspect ratio of `width` to `height`.
     */
    var aspectRatio: CGFloat {
        guard height != 0 else { return 0 }
        return width / height
    }
    
    /**
     SparrowKit: Maximum size of `width` and `height`.
     */
    var maxDimension: CGFloat {
        return max(width, height)
    }

    /**
     SparrowKit: Minimum size of `width` and `height`.
     */
    var minDimension: CGFloat {
        return min(width, height)
    }
}
#endif
