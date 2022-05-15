import Foundation

#if !os(Linux)
import CoreGraphics
#endif

#if os(iOS) || os(tvOS)
import UIKit.UIGeometry
#endif

public protocol Do {}

extension Do where Self: Any {
    
    /**
     SwiftBoost: Synaxic sugar for code reduction. Access instance or object properties using `do` via closures
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
