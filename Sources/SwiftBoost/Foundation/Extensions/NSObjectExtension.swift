import Foundation

public extension NSObject {
    
    var className: String { String(describing: type(of: self)) }
}
