import Foundation

public func delay(_ delay: TimeInterval, closure: @escaping @Sendable () -> Void) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when) {
        closure()
    }
}
