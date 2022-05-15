import Foundation

public extension NotificationCenter {
    
    func post(name: NSNotification.Name) {
        post(name: name, object: nil)
    }
}
