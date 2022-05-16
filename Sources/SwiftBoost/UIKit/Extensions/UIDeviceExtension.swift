#if canImport(UIKit) && (os(iOS) || os(tvOS))
import UIKit

public extension UIDevice {
    
    var isMac: Bool {
        if #available(iOS 14.0, tvOS 14.0, *) {
            if UIDevice.current.userInterfaceIdiom == .mac {
                return true
            }
        }
        #if targetEnvironment(macCatalyst)
        return true
        #else
        return false
        #endif
    }
}
#endif
