import XCTest
@testable import ANZ_Assesment

final class ConstantsTests: XCTestCase {
    func test_apiEndpoints() {
        XCTAssertTrue(Constants.API.Endpoints.users.contains(Constants.API.baseURL))
        XCTAssertTrue(Constants.API.Endpoints.users.hasSuffix("/users"))
    }
    
    func test_headers() {
        XCTAssertEqual(Constants.API.Headers.contentType, "Content-Type")
        XCTAssertEqual(Constants.API.Headers.applicationJSON, "application/json")
    }
    
    func test_errorMessages() {
        XCTAssertFalse(Constants.ErrorMessages.invalidURL.isEmpty)
        XCTAssertFalse(Constants.ErrorMessages.networkError.isEmpty)
        XCTAssertFalse(Constants.ErrorMessages.invalidResponse.isEmpty)
        XCTAssertFalse(Constants.ErrorMessages.decodingError.isEmpty)
    }
}
