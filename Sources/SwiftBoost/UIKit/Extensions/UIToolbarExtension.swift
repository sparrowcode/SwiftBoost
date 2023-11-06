#if canImport(UIKit) && os(iOS)
import UIKit

extension UIToolbar {
    
    /**
     SwiftBoost: Set appearance for tab bar.
     */
    @available(iOS 13.0, tvOS 13.0, *)
    public func setAppearance(_ value: ToolbarAppearance) {
        self.standardAppearance = value.standardAppearance
        if #available(iOS 15.0, tvOS 15.0, *) {
            self.scrollEdgeAppearance = value.scrollEdgeAppearance
        }
    }
    
    /**
     SwiftBoost: Appearance cases.
     */
    @available(iOS 13.0, tvOS 13.0, *)
    public enum ToolbarAppearance {
        
        case transparentAlways
        case transparentStandardOnly
        case opaqueAlways
        
        public var standardAppearance: UIToolbarAppearance {
            switch self {
            case .transparentAlways:
                let appearance = UIToolbarAppearance()
                appearance.configureWithTransparentBackground()
                return appearance
            case .transparentStandardOnly:
                let appearance = UIToolbarAppearance()
                appearance.configureWithDefaultBackground()
                return appearance
            case .opaqueAlways:
                let appearance = UIToolbarAppearance()
                appearance.configureWithDefaultBackground()
                return appearance
            }
        }
        
        public var scrollEdgeAppearance: UIToolbarAppearance {
            switch self {
            case .transparentAlways:
                let appearance = UIToolbarAppearance()
                appearance.configureWithTransparentBackground()
                return appearance
            case .transparentStandardOnly:
                let appearance = UIToolbarAppearance()
                appearance.configureWithTransparentBackground()
                return appearance
            case .opaqueAlways:
                let appearance = UIToolbarAppearance()
                appearance.configureWithDefaultBackground()
                return appearance
            }
        }
    }
}
#endif
