import XCTest
@testable import ANZ_Assesment

final class DataParserTests: XCTestCase {
    var parser: DataParser!
    
    override func setUp() {
        super.setUp()
        parser = DataParser()
    }
    
    override func tearDown() {
        parser = nil
        super.tearDown()
    }
    
    func test_parse_validData() throws {
        // Given
        let user = User(
            id: 1,
            name: "Vickie Konopelski",
            company: "Morar Group",
            username: "essika.Bins53",
            email: "Helena.Streich13@hotmail.com",
            address: "88650 Kings Highway",
            zip: "13561",
            state: "Pennsylvania",
            country: "Saint Kitts and Nevis",
            phone: "337.725.5078",
            profileImageUrl: "https://json-server.dev/ai-profiles/17.png"
        )
        let data = try JSONEncoder().encode([user])
        
        // When
        let decoded: [User] = try parser.parse(data)
        
        // Then
        XCTAssertEqual(decoded.count, 1)
        XCTAssertEqual(decoded.first?.name, "Vickie Konopelski")
    }
    
    func test_parse_invalidData() throws {
        // Given
        let invalidData = "invalid json".data(using: .utf8)!
        
        // When/Then
        XCTAssertThrowsError(try parser.parse(invalidData) as [User]) { error in
            XCTAssertEqual((error as? NetworkError)?.localizedDescription, NetworkError.decodingError.localizedDescription)
        }
    }
    
    func test_parse_emptyData() throws {
        // Given
        let emptyData = "[]".data(using: .utf8)!
        
        // When
        let decoded: [User] = try parser.parse(emptyData)
        
        // Then
        XCTAssertTrue(decoded.isEmpty)
    }
    
    func test_parse_customJSONDecoder() throws {
        // Given
        let customDecoder = JSONDecoder()
        customDecoder.keyDecodingStrategy = .convertFromSnakeCase
        parser = DataParser(jsonDecoder: customDecoder)
        
        let json = """
            [{
                "id": 1,
                "name": "Vickie Konopelski",
                "company": "Morar Group",
                "username": "Jessika.Bins53",
                "email": "Helena.Streich13@hotmail.com",
                "address": "88650 Kings Highway",
                "zip": "13561",
                "state": "Pennsylvania",
                "country": "Saint Kitts and Nevis",
                "phone": "337.725.5078",
                "photo": "https://json-server.dev/ai-profiles/17.png"
            }]
        """.data(using: .utf8)!
        
        // When
        let decoded: [User] = try parser.parse(json)
        
        // Then
        XCTAssertEqual(decoded.first?.profileImageUrl, "https://json-server.dev/ai-profiles/17.png")
    }
}
