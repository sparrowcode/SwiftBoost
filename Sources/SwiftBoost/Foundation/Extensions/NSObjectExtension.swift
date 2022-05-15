import Foundation

extension NSObject {
    
    public var className: String {
        return String(describing: type(of: self))
    }
}
