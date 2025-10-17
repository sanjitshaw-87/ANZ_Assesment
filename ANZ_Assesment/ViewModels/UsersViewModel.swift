import Foundation
@MainActor
final class UsersViewModel: ObservableObject {
    @Published private(set) var users: [User] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchUsers() async {
        isLoading = true
        errorMessage = nil
        
        do {
            users = try await networkService.fetchUsers()
        } catch let error as NetworkError {
            errorMessage = error.localizedDescription
            users = []
        } catch {
            errorMessage = error.localizedDescription
            users = []
        }
        
        isLoading = false
    }
}
