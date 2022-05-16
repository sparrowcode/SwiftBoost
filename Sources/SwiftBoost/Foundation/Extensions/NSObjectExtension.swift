import Foundation

public extension NSObject {
    
    var className: String {
        return String(describing: type(of: self))
    }
}
