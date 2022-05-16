#if canImport(UIKit) && (os(iOS) || os(tvOS))
import UIKit

public let kCFBundleDisplayNameKey = "CFBundleDisplayName"
public let kCFBundleShortVersionStringKey = "CFBundleShortVersionString"

public extension UIApplication {
    
    var bundleIdentifier: String? { Bundle.main.bundleIdentifier }
    var displayName: String? { Bundle.main.object(forInfoDictionaryKey: kCFBundleDisplayNameKey) as? String }
    var version: String? {  Bundle.main.object(forInfoDictionaryKey: kCFBundleShortVersionStringKey) as? String }
    var buildNumber: String? { Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String }
    
    func openSettings() {
        DispatchQueue.main.async {
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { _ in })
            }
        }
    }
}
#endif
