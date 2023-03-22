import Foundation

public struct FileManagerDestination {
    
    // MARK: - Data
    
    public var file: String
    public var directory: URL
    
    public var url: URL { directory.appendingPathComponent(file) }
    
    // MARK: - Init
    
    public init(directory: FileManager.SearchPathDirectory = .documentDirectory, path: String, file: String) {
        let fileManager = FileManager.default
        do {
            let documentDirectory = try fileManager.url(for: directory, in: .userDomainMask, appropriateFor: nil, create: true)
            self.directory = documentDirectory.appendingPathComponent(Self.cleaned(path))
        } catch {
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
