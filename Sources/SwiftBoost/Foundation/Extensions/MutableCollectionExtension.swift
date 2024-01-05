import Foundation

public extension MutableCollection where Self: RandomAccessCollection {
    
    func sorted<Value>(
        by keyPath: KeyPath<Element, Value>,
        using valuesAreInIncreasingOrder: (Value, Value) throws -> Bool
    ) rethrows -> [Element] {
        try sorted {
            try valuesAreInIncreasingOrder($0[keyPath: keyPath], $1[keyPath: keyPath])
        }
    }

    func sorted<Value: Comparable>(
        by keyPath: KeyPath<Element, Value>,
        order: MutableCollectionOrder<Value>
    ) -> [Element] {
        sorted(by: keyPath, using: order.operator)
    }
}

public enum MutableCollectionOrder<Value: Comparable> {
    
    // MARK: - Cases
    
    /// Represents ascending order. In this case, the associated operator function is `<`.
    case ascending
    /// Represents descending order. In this case, the associated operator function is `>`.
    case descending
    
    // MARK: - Properties
    
    public var `operator`: (Value, Value) -> Bool {
        switch self {
        case .ascending:
            return (<)
        case .descending:
            return (>)
        }
    }
}
