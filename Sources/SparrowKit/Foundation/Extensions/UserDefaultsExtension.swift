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

#if canImport(Foundation)
import Foundation

public extension UserDefaults {
    
    /**
     SparrowKit: Get `Date`.
     
     - parameter key: Key in current `UserDefaults`.
     */
    func date(forKey key: String) -> Date? {
        return object(forKey: key) as? Date
    }
    
    /**
     SparrowKit: Save codable object.
     
     - parameter object: Codable object for save.
     - parameter key: Key of saving object.
     */
    func set<T: Codable>(object: T, forKey: String) throws {
        let jsonData = try? JSONEncoder().encode(object)
        set(jsonData, forKey: forKey)
    }
    
    /**
     SparrowKit: Get codable object.
     
     - parameter object: Codable object for save.
     - parameter key: Key of saving object.
     */
    func get<T: Codable>(objectType: T.Type, forKey: String) throws -> T? {
        guard let result = value(forKey: forKey) as? Data else { return nil }
        return try JSONDecoder().decode(objectType, from: result)
    }
}
#endif
