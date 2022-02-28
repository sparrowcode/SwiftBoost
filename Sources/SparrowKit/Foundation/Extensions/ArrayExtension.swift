// The MIT License (MIT)
// Copyright © 2020 Ivan Vorobei (hello@ivanvorobei.io)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

extension Array {
    
    /**
     SparrowKit: This method rearrange element in array.
     
     - parameter fromIndex: Source index.
     - parameter toIndex: Destination index.
     */
    public func rearrange(fromIndex: Int, toIndex: Int) -> [Element] {
        var array = self
        let element = array.remove(at: fromIndex)
        array.insert(element, at: toIndex)
        return array
    }
    
    /**
     SparrowKit: This method split array of elements into chunks of a size  specify
     
     Take a look at this example:
     ```
     let array = [1,2,3,4,5,6,7]
     array.chuncked(by: 3) // [[1,2,3], [4,5,6], [7]]
     ```
     
     - parameter chunkSize: Subarray size.
     */
    public func chunked(by chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize).map {
            Array(self[$0..<Swift.min($0 + chunkSize, self.count)])
        }
    }
}

extension Array where Element: Equatable {
    
    /**
     SparrowKit: This method remove duplicates in array.
     
     Take a look at this example:
     ```
     let array = [1,2,3,3,3,6,7]
     array.removedDuplicates() // [1,2,3,6,7]
     ```
     */
    public func removedDuplicates() -> [Element] {
        var result = [Element]()
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        return result
    }
}

extension Array where Element: NSCopying {
    
    /**
     SparrowKit: Make deep copy of array objects.
     */
    public func copy() -> [Element] {
        return self.map { $0.copy() as! Element }
    }
}
