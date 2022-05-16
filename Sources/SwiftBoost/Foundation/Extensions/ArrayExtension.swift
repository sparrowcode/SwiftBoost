import Foundation

public extension Array {
    
    /**
     SwiftBoost:
     */
    func rearrange(fromIndex: Int, toIndex: Int) -> [Element] {
        var array = self
        let element = array.remove(at: fromIndex)
        array.insert(element, at: toIndex)
        return array
    }
    
    /**
     SwiftBoost: Split array of elements into chunks of a size  specify. Example:
     ```
     let array = [1,2,3,4,5,6,7]
     array.chuncked(by: 3) // [[1,2,3], [4,5,6], [7]]
     ```
     
     - parameter chunkSize: Subarray size.
     */
    func chunked(by chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize).map {
            Array(self[$0..<Swift.min($0 + chunkSize, self.count)])
        }
    }
}

public extension Array where Element: Equatable {
    
    /**
     SwiftBoost: Remove duplicates in array.
     
     Take a look at this example:
     ```
     let array = [1,2,3,3,3,6,7]
     array.removedDuplicates() // [1,2,3,6,7]
     ```
     */
    func removedDuplicates() -> [Element] {
        var result = [Element]()
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        return result
    }
}
