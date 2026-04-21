import Foundation

extension FileManager {
    
    public func fileExist(at destination: FileManagerDestination) -> Bool {
        return fileExists(atPath: destination.url.path)
    }
    
    public func folderExist(for destination: FileManagerDestination) -> Bool {
        return fileExists(atPath: destination.directory.path)
    }
    
    public func get(from destination: FileManagerDestination) -> Data? {
        do {
            return try Data(contentsOf: destination.url)
        } catch {
            print("Can't get data, error: \(error.localizedDescription)")
            return nil
        }
    }
    
    public func save(data: Data, to destination: FileManagerDestination) {
        do {
            // If not exist directory, create it
            if !fileExists(atPath: destination.directory.path) {
                try createDirectory(at: destination.directory, withIntermediateDirectories: true, attributes: nil)
            }
            // Save file to directory
            try data.write(to: destination.url, options: .atomicWrite)
        } catch {
            print("Can't save data, error: \(error.localizedDescription)")
        }
    }
    
    public func delete(at destination: FileManagerDestination) {
        do {
            if fileExists(atPath: destination.url.path) {
                try removeItem(at: destination.url)
            }
        } catch {
            print("Can't delete data, error: \(error.localizedDescription)")
        }
    }
    
    public func delete(at url: URL) {
        do {
            if fileExists(atPath: url.path) {
                try removeItem(at: url)
            }
        } catch {
            print("Can't delete data, error: \(error.localizedDescription)")
        }
    }
}
