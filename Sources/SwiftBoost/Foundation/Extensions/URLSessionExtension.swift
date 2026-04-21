import Foundation

public extension URLSession {
    
    enum AppError: Error {
        
        case invalidURL(String)
        case networkError(Error)
        case noResponse
        case decodingError(Error)
        
        public func errorMessage() -> String {
            switch self {
            case .invalidURL(let str):
                return "bad URL: \(str)"
            case .networkError(let error):
                return "network Error: \(error)"
            case .noResponse:
                return "no network response"
            case .decodingError(let error):
                return "decoding error: \(error)"
            }
        }
    }
    
    enum HTTPMethod {
        
        case get
        case post
        case put
        case delete
        
        var id: String {
            switch self {
            case .get: return "get"
            case .post: return "post"
            case .put: return "put"
            case .delete : return "delete"
            }
        }
    }
    
    enum ContentType {
        
        case application_json
        
        var id: String {
            switch self {
            case .application_json:
                "application/json"
            }
        }
    }
    
    @available(iOS 15, macOS 12, tvOS 15, watchOS 8, *)
    static func request(
        url: String,
        method: HTTPMethod,
        body: [String: Any?]? = nil,
        contentTypeHeader: ContentType? = nil
    ) async throws -> (Data, HTTPURLResponse) {
        guard let url = URL(string: url) else {
            throw AppError.invalidURL(url)
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.id

        if var body = body {
            body = body.compactMapValues { $0 }
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                throw AppError.decodingError(error)
            }
        }

        /* Default to application/json when a body is present. Without Content-Type,
           servers may fall back to form-urlencoded parsing, which treats `%20` and `+`
           as equivalent for spaces and can round-trip values back as `+`. */
        let resolvedContentType = contentTypeHeader ?? (request.httpBody != nil ? .application_json : nil)
        if let resolvedContentType {
            request.setValue(resolvedContentType.id, forHTTPHeaderField: "Content-Type")
        }

        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await URLSession.shared.data(for: request)
        } catch {
            throw AppError.networkError(error)
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw AppError.noResponse
        }
        return (data, httpResponse)
    }
}
