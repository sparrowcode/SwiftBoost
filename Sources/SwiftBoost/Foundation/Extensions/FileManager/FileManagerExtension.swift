import Foundation

extension FileManager {
    
    public func fileExist(at destination: FileManagerDestination) -> Bool {
        return fileExists(atPath: destination.url.path)
    }
    
    public func get(from destination: FileManagerDestination) -> Data? {
        do {
            return try Data(contentsOf: destination.url)
        } catch {
            debug("Can't get data, error: \(error.localizedDescription)")
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
            debug("Can't save data, error: \(error.localizedDescription)")
        }
    }
    
    public func delete(at destination: FileManagerDestination) {
        do {
            if fileExists(atPath: destination.url.path) {
                try removeItem(at: destination.url)
            }
        } catch {
            debug("Can't delete data, error: \(error.localizedDescription)")
        }
    }
}
