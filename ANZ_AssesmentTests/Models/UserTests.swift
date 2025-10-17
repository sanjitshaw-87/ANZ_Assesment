import XCTest
@testable import ANZ_Assesment

final class UserTests: XCTestCase {
    func test_userDecoding() throws {
        // Given
        let json = """
            {
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
            }
        """.data(using: .utf8)!
        
        // When
        let user = try JSONDecoder().decode(User.self, from: json)
        
        // Then
        XCTAssertEqual(user.id, 1)
        XCTAssertEqual(user.name, "Vickie Konopelski")
        XCTAssertEqual(user.company, "Morar Group")
        XCTAssertEqual(user.username, "Jessika.Bins53")
        XCTAssertEqual(user.email, "Helena.Streich13@hotmail.com")
        XCTAssertEqual(user.address, "88650 Kings Highway")
        XCTAssertEqual(user.zip, "13561")
        XCTAssertEqual(user.state, "Pennsylvania")
        XCTAssertEqual(user.country, "Saint Kitts and Nevis")
        XCTAssertEqual(user.phone, "337.725.5078")
        XCTAssertEqual(user.profileImageUrl, "https://json-server.dev/ai-profiles/17.png")
    }
    
    func test_userEncoding() throws {
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
        
        // When
        let encodedData = try JSONEncoder().encode(user)
        let decodedUser = try JSONDecoder().decode(User.self, from: encodedData)
        
        // Then
        XCTAssertEqual(user.id, decodedUser.id)
        XCTAssertEqual(user.name, decodedUser.name)
        XCTAssertEqual(user.company, decodedUser.company)
        XCTAssertEqual(user.username, decodedUser.username)
        XCTAssertEqual(user.email, decodedUser.email)
        XCTAssertEqual(user.address, decodedUser.address)
        XCTAssertEqual(user.zip, decodedUser.zip)
        XCTAssertEqual(user.state, decodedUser.state)
        XCTAssertEqual(user.country, decodedUser.country)
        XCTAssertEqual(user.phone, decodedUser.phone)
        XCTAssertEqual(user.profileImageUrl, decodedUser.profileImageUrl)
    }
    
    func test_userDecodingWithMissingFields() {
        // Given
        let incompleteJson = """
        {
            "id": 1,
            "name": "Vickie Konopelski"
        }
        """.data(using: .utf8)!
        
        // When/Then
        XCTAssertThrowsError(try JSONDecoder().decode(User.self, from: incompleteJson)) { error in
            XCTAssertTrue(error is DecodingError)
        }
    }
}
