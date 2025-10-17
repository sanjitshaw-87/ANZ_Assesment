import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError(String)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return Constants.ErrorMessages.invalidURL
        case .invalidResponse:
            return Constants.ErrorMessages.invalidResponse
        case .decodingError:
            return Constants.ErrorMessages.decodingError
        case .serverError(let message):
            return message
        }
    }
}

protocol NetworkServiceProtocol {
    func fetchUsers() async throws -> [User]
}

class NetworkService: NetworkServiceProtocol {
    private let session: URLSession
    private let parser: DataParserProtocol
    
    init(session: URLSession = .shared, parser: DataParserProtocol = DataParser()) {
        self.session = session
        self.parser = parser
    }
    
    func fetchUsers() async throws -> [User] {
        guard let url = URL(string: Constants.API.Endpoints.users) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.setValue(Constants.API.Headers.applicationJSON,
                        forHTTPHeaderField: Constants.API.Headers.contentType)
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        return try parser.parse(data)
    }
}
