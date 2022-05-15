import Foundation

public func delay(_ delay: TimeInterval, closure: @escaping ClosureVoid) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when) {
        closure()
    }
}
