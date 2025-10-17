struct User: Identifiable, Codable {
    let id: Int
    let name: String
    let company: String
    let username: String
    let email: String
    let address: String
    let zip: String
    let state: String
    let country: String
    let phone: String
    let profileImageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case company
        case username
        case email
        case address
        case zip
        case state
        case country
        case phone
        case profileImageUrl = "photo"
    }
}
