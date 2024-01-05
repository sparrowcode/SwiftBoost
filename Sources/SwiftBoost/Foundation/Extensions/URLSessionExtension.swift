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
                return "badURL: \(str)"
            case .networkError(let error):
                return "networkError: \(error)"
            case .noResponse:
                return "no network response"
            case .decodingError(let error):
                return "decoding error: \(error)"
            }
        }
    }
    
    enum HTTPMethod {
        
        case get
        
        var id: String {
            switch self {
            case .get: return "get"
            }
        }
    }
    
    static func request(
        url: String,
        method: HTTPMethod,
        completion: @escaping (AppError?, Data?, HTTPURLResponse?) ->Void)
    {
        guard let url = URL(string: url) else {
            completion(AppError.invalidURL(url), nil, nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.id
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
