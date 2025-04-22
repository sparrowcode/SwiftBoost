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
    
    var rootController: UIViewController? {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return nil }
        guard let rootViewController = scene.windows.first?.rootViewController else { return nil }
        return rootViewController
    }
    
    var topController: UIViewController? {
        if var topController = self.rootController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
    func openMailTo(_ email: String, subject: String, body: String = .empty) {
        let coded = "mailto:\(email)?subject=\(subject)&body=\(body)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let coded, let emailURL = URL(string: coded), canOpenURL(emailURL) {
            open(emailURL)
        }
    }
}
#endif
