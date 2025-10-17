import Foundation

protocol DataParserProtocol {
    func parse<T: Decodable>(_ data: Data) throws -> T
}

final class DataParser: DataParserProtocol {
    private let jsonDecoder: JSONDecoder
    
    init(jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.jsonDecoder = jsonDecoder
    }
    
    func parse<T: Decodable>(_ data: Data) throws -> T {
        do {
            let decoded = try jsonDecoder.decode(T.self, from: data)
            return decoded
        } catch {
            throw NetworkError.decodingError
        }
    }
}