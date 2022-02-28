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

public enum SPFileManager {
    
    public static func getData(of destination: SPFileManagerDestination) -> Data? {
        do {
            return try Data(contentsOf: destination.url)
        } catch {
            SPLogger.kit(message: "Can't get data, error: \(error.localizedDescription)")
            return nil
        }
    }
    
    public static func fileExist(at destination: SPFileManagerDestination) -> Bool {
        let fileManager = FileManager.default
        return fileManager.fileExists(atPath: destination.url.path)
    }
    
    public static func save(to destination: SPFileManagerDestination, data: Data) {
        let fileManager = FileManager.default
        do {
            // If not exist directory, create it
            if !fileManager.fileExists(atPath: destination.directory.path) {
                try fileManager.createDirectory(at: destination.directory, withIntermediateDirectories: true, attributes: nil)
            }
            
            // Save file to directory
            try data.write(to: destination.url, options: .atomicWrite)
        } catch {
            SPLogger.kit(message: "Can't save data, error: \(error.localizedDescription)")
        }
    }
    
    public static func delete(at destination: SPFileManagerDestination) {
        let fileManager = FileManager.default
        do {
            if fileManager.fileExists(atPath: destination.url.path) {
                try fileManager.removeItem(at: destination.url)
            }
        } catch {
            SPLogger.kit(message: "Can't delete data, error: \(error.localizedDescription)")
        }
    }
}
