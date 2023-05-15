import Foundation

/// This extension provides additional sorting capabilities for mutable collections that also conform to `RandomAccessCollection`.
///
/// These extension methods allow for easy sorting of collections where the elements have Comparable properties.
///
/// Example:
///
/// ```swift
/// struct Person {
///     let name: String
///     let age: Int
/// }
///
/// var people = [
///     Person(name: "Alice", age: 30),
///     Person(name: "Bob", age: 20),
///     Person(name: "Charlie", age: 25)
/// ]
///
/// // Sort by name in ascending order.
/// let sortedByName = people.sorted(by: \.name, order: .ascending)
///
/// // Sort by age in descending order.
/// let sortedByAge = people.sorted(by: \.age, order: .descending)
///
/// // Custom sort: sort by name length.
/// let sortedByNameLength = people.sorted(by: \.name) { name1, name2 in
///     return name1.count < name2.count
/// }
/// ```
///
/// - Note: These functions use Swift's `keyPath` feature to determine which property to sort by.
public extension MutableCollection where Self: RandomAccessCollection {
    
    /// Sorts the elements of the collection in the order specified by a closure that compares elements by a key path.
    ///
    /// - Parameters:
    ///   - keyPath: A key path to a comparable value on which to sort the collection's elements.
    ///   - valuesAreInIncreasingOrder: A closure that takes two arguments and returns `true` if the first value should appear before the second in the sorted sequence, and `false` otherwise.
    /// - Returns: An array of the collection's elements sorted by the provided key path and comparison closure.
    func sorted<Value>(
        by keyPath: KeyPath<Element, Value>,
        using valuesAreInIncreasingOrder: (Value, Value) throws -> Bool
    ) rethrows -> [Element] {
        try sorted {
            try valuesAreInIncreasingOrder($0[keyPath: keyPath], $1[keyPath: keyPath])
        }
    }
    
    /// Sorts the elements of the collection in the order specified by a `MutableCollectionOrder` instance and a key path.
    ///
    /// - Parameters:
    ///   - keyPath: A key path to a comparable value on which to sort the collection's elements.
    ///   - order: A `MutableCollectionOrder` instance specifying the order in which to sort the elements.
    /// - Returns: An array of the collection's elements sorted by the provided key path and order.
    func sorted<Value: Comparable>(
        by keyPath: KeyPath<Element, Value>,
        order: MutableCollectionOrder<Value>
    ) -> [Element] {
        sorted(by: keyPath, using: order.operator)
    }
}

// MARK: - Helper Utlity Type

/// `MutableCollectionOrder` is an enumeration representing the ordering options for collections of `Comparable` values.
///
/// This enum has two cases: `.ascending` and `.descending`, representing ascending and descending order respectively.
///
/// - Note:
///   You can retrieve the associated comparison operator function for each case by accessing the `.operator` property.
///   This operator function can be used to compare `Value` instances in a way that corresponds to the specified order.
public enum MutableCollectionOrder<Value: Comparable> {
    
    // MARK: - Cases
    
    /// Represents ascending order. In this case, the associated operator function is `<`.
    case ascending
    /// Represents descending order. In this case, the associated operator function is `>`.
    case descending
    
    // MARK: - Properties
    
    /// Returns a comparison operator function corresponding to the order represented by the case.
    /// For `.ascending`, this function is `<`. For `.descending`, it's `>`.
    public var `operator`: (Value, Value) -> Bool {
        switch self {
        case .ascending:
            return (<)
        case .descending:
            return (>)
        }
    }
}
