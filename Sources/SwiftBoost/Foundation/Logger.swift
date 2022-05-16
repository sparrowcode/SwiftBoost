import Foundation

/**
 SwiftBoost: Help to manage prints in console during your app running.
 You can set when levels you want see with configure.
 
 - important:
 Requerid before call `configure()` method with list of allowed levels.
 */
public enum Logger {
    
    public static func configure(levels: [Level], fileNameMode: FileNameMode) {
        Configurator.shared.levels = levels
        Configurator.shared.fileNameMode = fileNameMode
    }
    
    public static func log(_ level: Level, message: LogMessage, filePath: String) {
        if Configurator.shared.levels.contains(level) {
            
            // Formatting text.
            var formattedMessage = message
            formattedMessage = formattedMessage.removedSuffix(String.dot)
            
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
    
    // MARK: - Classes
    
    public typealias LogMessage = String
    
    /**
     SwiftBoost: Available levels for logging.
     
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
    
    public enum FileNameMode {
        
        case show
        case hide
    }
    
    // MARK: - Sigltone
    
    private struct Configurator {
        
        var levels: [Level] = []
        var fileNameMode: FileNameMode = .show
        
        static var shared = Configurator()
        private init() {}
    }
}

// MARK: - Public Functions

public func error(_ message: Logger.LogMessage, filePath: String = #fileID) {
    Logger.log(.error, message: message, filePath: filePath)
}

public func debug(_ message: Logger.LogMessage, filePath: String = #fileID) {
    Logger.log(.debug, message: message, filePath: filePath)
}
