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

public extension UIScrollView {
    
    /**
     SparrowKit: Rect of visible content.
     */
    var visibleRect: CGRect {
        let contentWidth = contentSize.width - contentOffset.x
        let contentHeight = contentSize.height - contentOffset.y
        return CGRect(
            origin: contentOffset,
            size: CGSize(
                width: min(min(bounds.size.width, contentSize.width), contentWidth),
                height: min(min(bounds.size.height, contentSize.height), contentHeight)
            )
        )
    }
    
    /**
     SparrowKit: Represent position of scroll.
     */
    enum Side {
        case top, bottom, left, right
    }
    
    /**
     SparrowKit: Scroll to specific position.
     
     - parameter side: Position to scroll.
     - parameter animated: Is animated scroll.
     */
    func scrollTo(_ side: Side, animated: Bool) {
        let point: CGPoint
        
        switch side {
        case .top:
            if contentSize.height < bounds.height { return }
            point = CGPoint(
                x: contentOffset.x,
                y: -(contentInset.top + safeAreaInsets.top)
            )
        case .bottom:
            if contentSize.height < bounds.height { return }
            point = CGPoint(
                x: contentOffset.x,
                y: max(0, contentSize.height - bounds.height) + contentInset.bottom + safeAreaInsets.bottom
            )
        case .left:
            point = CGPoint(x: -contentInset.left, y: contentOffset.y)
        case .right:
            point = CGPoint(x: max(0, contentSize.width - bounds.width) + contentInset.right, y: contentOffset.y)
        }
        
        setContentOffset(point, animated: animated)
    }
}
#endif
