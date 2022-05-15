import Foundation

public extension Bool {
    
    /**
     SwiftBoost: Convert bool to Int.
     
     If `Bool` is true, `Int` is equal 1. Else is equal 0.
     */
    var int: Int {
        return self ? 1 : 0
    }
    
    /**
     SwiftBoost: Convert bool to String.
     
     If `Bool` is true, `String` is equal "true". Else is equal "false".
     */
    var string: String {
        return self ? "true" : "false"
    }
}

