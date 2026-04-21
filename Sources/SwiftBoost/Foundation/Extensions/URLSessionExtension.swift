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
    
    static func request(
        url: String,
        method: HTTPMethod,
        body: [String: Any?]? = nil,
        contentTypeHeader: ContentType? = nil,
        completion: @escaping (AppError?, Data?, HTTPURLResponse?) -> Void
    ) {
        guard let url = URL(string: url) else {
            completion(AppError.invalidURL(url), nil, nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.id

        // Body
        if var body = body {

            body = body.compactMapValues { $0 } // delete `nil` values

            do {
                let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
                request.httpBody = jsonData
            } catch {
                completion(.decodingError(error), nil, nil)
                return
            }
        }

        /* Default to application/json when a body is present. Without Content-Type,
           servers may fall back to form-urlencoded parsing, which treats `%20` and `+`
           as equivalent for spaces and can round-trip values back as `+`. */
        let resolvedContentType = contentTypeHeader ?? (request.httpBody != nil ? .application_json : nil)
        if let resolvedContentType {
            request.setValue(resolvedContentType.id, forHTTPHeaderField: "Content-Type")
        }
        
        // Make Request
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                completion(AppError.noResponse, nil, nil)
                return
            }
            
            if let error = error {
                completion(AppError.networkError(error), nil, response)
            } else if let data = data {
                completion(nil, data, response)
            }
        }.resume()
    }
}
