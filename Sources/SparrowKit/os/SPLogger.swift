// The MIT License (MIT)
// Copyright © 2020 Ivan Varabei (varabeis@icloud.com)
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
// SOFTWARE. IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#if canImport(os)
import os

public enum SPLogger {
    
    // MARK: - Configure
    
    public static func configure(levels: [Level] = Level.allCases) {
        Configurator.shared.levels = levels
    }
    
    // MARK: - Logging
    
    public static func log(_ level: Level, message: LogMessage) {
        if Configurator.shared.levels.contains(level) {
            print(message)
        }
    }
    
    // MARK: - Classes
    
    public typealias LogMessage = String
    
    public enum Level: String, CaseIterable {
        
        case httpResponse
        case error
        case debug
        
        public var description: String {
            switch self {
            case .httpResponse: return "HTTP Response"
            case .error: return "Error"
            case .debug: return "Debug"
            }
        }
    }
    
    private static func logType(for level: Level) -> OSLogType {
        switch level {
        case .httpResponse: return .debug
        case .debug: return .debug
        case .error: return .error
        }
    }
    
    private struct Configurator {
        
        var levels: [Level] = []
        
        static var shared = Configurator()
        private init() {}
    }
}

// MARK: - Public functions

public func error(_ message: SPLogger.LogMessage) {
    SPLogger.log(.error, message: message)
}

public func debug(_ message: SPLogger.LogMessage) {
    SPLogger.log(.debug, message: message)
}
#endif
