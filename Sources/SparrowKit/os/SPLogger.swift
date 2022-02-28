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

#if canImport(os)
import os
import Foundation

/**
 SparrowKit: Help to manage prints in console during your app running.
 You can set when levels you want see with configure.
 
 - important:
 Requerid before call `configure()` method with list of allowed levels.
 */
public enum SPLogger {
    
    /**
     SparrowKit: Configuration method, need call usually in AppDelegate.
     
     - parameter levels: Array of levels wich allowed for log.
     */
    public static func configure(levels: [Level], fileNameMode: FileNameMode) {
        Configurator.shared.levels = levels
        Configurator.shared.fileNameMode = fileNameMode
    }
    
    /**
     SparrowKit: Logging message with level.
     
     - parameter level: Level of message, like `error` or `debug`.
     - parameter message: Text message.
     
     */
    public static func log(_ level: Level, message: LogMessage, filePath: String) {
        if Configurator.shared.levels.contains(level) {
            
            // Formatting text.
            var formattedMessage = message
            formattedMessage.removeSuffix(String.dot)
            
            // Adding dot if not have.
            if !formattedMessage.hasSuffix(String.dot) {
                formattedMessage = formattedMessage + String.dot
            }
            
            // Adding filename if need.
            switch Configurator.shared.fileNameMode {
            case .show:
                if let fileName = URL(string: filePath)?.lastPathComponent {
                    formattedMessage += " [\(fileName)]"
                } else {
                    formattedMessage += " [\(filePath)]"
                }
            case .hide:
                break
            }
            
            print(formattedMessage)
        }
    }
    
    /**
     Internal log for lib.
     */
    static func kit(message: LogMessage) {
        print("SparrowKit, " + message)
    }
    
    // MARK: - Classes
    
    /**
     SparrowKit: Wrappers of log message.
     */
    public typealias LogMessage = String
    
    /**
     SparrowKit: Available levels for logging.
     
     Use `httpResponse` for response of API requests.
     Use `error` for critical bugs.
     Use `debug` for develop process.
     */
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
    
    /**
     SparrowKit: Modes for show or hide filename in prints.
     */
    public enum FileNameMode {
        
        case show
        case hide
    }
    
    /**
     SparrowKit: Now not support new logging system from iOS 14
     becouse no way pass string object as test to method.
     But it convertor type for system logger.
     I hope we can use it later.
     */
    @available(macOS 10.12, *)
    private static func logType(for level: Level) -> OSLogType {
        switch level {
        case .httpResponse: return .debug
        case .debug: return .debug
        case .error: return .error
        }
    }
    
    /**
     SparrowKit: Sigltone.
     
     Using for storage configured levels.
     */
    private struct Configurator {
        
        var levels: [Level] = []
        var fileNameMode: FileNameMode = .show
        
        static var shared = Configurator()
        private init() {}
    }
}

// MARK: - Public Functions

/**
 Logging message of level `error` via `SPLogger` system.
 */
public func error(_ message: SPLogger.LogMessage, filePath: String = #fileID) {
    SPLogger.log(.error, message: message, filePath: filePath)
}

/**
 Logging message of level `debug` via `SPLogger` system.
 */
public func debug(_ message: SPLogger.LogMessage, filePath: String = #fileID) {
    SPLogger.log(.debug, message: message, filePath: filePath)
}
#endif
