import Foundation

enum Constants {
    enum API {
        static let baseURL = "https://fake-json-api.mock.beeceptor.com"
        
        enum Endpoints {
            static let users = "\(baseURL)/users"
        }
        
        enum Headers {
            static let contentType = "Content-Type"
            static let applicationJSON = "application/json"
        }
    }
    
    enum ErrorMessages {
        static let invalidURL = "Invalid URL"
        static let networkError = "Network error occurred"
        static let invalidResponse = "Invalid response from server"
        static let decodingError = "Error decoding data"
    }
}
