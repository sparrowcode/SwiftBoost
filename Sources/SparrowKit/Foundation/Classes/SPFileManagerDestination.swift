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

public struct SPFileManagerDestination {
    
    // MARK: - Data
    
    public var file: String
    public var directory: URL
    
    public var url: URL { directory.appendingPathComponent(file) }
    
    // MARK: - Init
    
    public init(directory: FileManager.SearchPathDirectory = .documentDirectory, path: String, file: String) {
        let fileManager = FileManager.default
        do {
            let documentDirectory = try fileManager.url(for: directory, in: .userDomainMask, appropriateFor: nil, create: true)
            self.directory = documentDirectory
            let cleanedPath = SPFileManagerDestination.cleaned(path)
            self.directory = documentDirectory.appendingPathComponent(cleanedPath)
        } catch {
            SPLogger.kit(message: "Can't create destination, error: \(error.localizedDescription)")
            fatalError()
        }
        self.file = file
    }
    
    public init(fileName: String) {
        let bundleFileURL = Bundle.main.url(forResource: fileName, withExtension: nil)
        self.directory = bundleFileURL?.deletingLastPathComponent() ?? URL.init(string: .empty)!
        self.file = bundleFileURL?.lastPathComponent ?? .empty
    }
    
    // MARK: - Private
    
    private static func cleaned(_ path: String) -> String {
        return path.removedPrefix("/").removedSuffix("/")
    }
}
