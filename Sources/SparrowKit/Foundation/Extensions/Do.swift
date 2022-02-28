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

#if canImport(Foundation)
import Foundation
#endif
#if !os(Linux)
import CoreGraphics
#endif
#if os(iOS) || os(tvOS)
import UIKit.UIGeometry
#endif

public protocol Do {}

extension Do where Self: Any {
    
    /**
     SparrowKit: Synaxic sugar for code reduction. Access instance or object properties using `do` via closures
     ```
     let titleLabel = UILabel().do {
         $0.font = .systemFont(ofSize: 34, weight: .bold)
         $0.textColor = .systemRed
     }
     ```
        --- or ---
     ```
     let titleLabel = UILabel()
     titleLabel.do {
         $0.font = .systemFont(ofSize: 34, weight: .bold)
         $0.textColor = .systemRed
     }
     ```
     */
    @discardableResult @inlinable
    public func `do`(_ block: (Self) throws -> Void) rethrows -> Self {
        try block(self)
        return self
    }
    
}

extension NSObject: Do {}

#if !os(Linux)
extension CGPoint: Do {}
extension CGRect: Do {}
extension CGSize: Do {}
extension CGVector: Do {}
#endif

extension Array: Do {}
extension Dictionary: Do {}
extension Set: Do {}

#if os(iOS) || os(tvOS)
extension UIEdgeInsets: Do {}
extension UIOffset: Do {}
extension UIRectEdge: Do {}
#endif
