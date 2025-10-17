import XCTest
@testable import ANZ_Assesment

class MockNetworkService: NetworkServiceProtocol {
    var mockResult: Result<[User], NetworkError>?
    var addDelay = false
    private let dataParser: DataParserProtocol
    
    init(dataParser: DataParserProtocol = DataParser()) {
        self.dataParser = dataParser
    }
    
    func fetchUsers() async throws -> [User] {
        if addDelay {
            try await Task.sleep(for: .seconds(1)) // 1 second delay
        }
        
        // If mockResult is set, use it
        if let mockResult = mockResult {
            switch mockResult {
            case .success(let users):
                return users
            case .failure(let error):
                throw error
            }
        }
        
        // Read from mock JSON file
        guard let path = Bundle(for: type(of: self)).path(forResource: "MockJson", ofType: "json") else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            return try dataParser.parse(data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}
