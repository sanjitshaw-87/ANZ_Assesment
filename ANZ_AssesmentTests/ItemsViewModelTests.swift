import XCTest
@testable import ANZ_Assesment

@MainActor
final class ItemsViewModelTests: XCTestCase {
    var viewModel: ItemsViewModel!
    var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        viewModel = ItemsViewModel(networkService: mockNetworkService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    func test_fetchUsers_success() async {
        // Given - Setup success case with mock data
        // When - Fetch users
        await viewModel.fetchUsers()
        
        // Then - Verify success state
        XCTAssertFalse(viewModel.isLoading, "Should not be loading after success")
        XCTAssertNil(viewModel.errorMessage, "Should not have error message")
        XCTAssertEqual(viewModel.users.count, 10, "Should have correct number of users")
        XCTAssertEqual(viewModel.users.first?.name, "Vickie Konopelski", "Should have correct user data")
    }
    
    func test_fetchUsers_networkError() async {
        // Given - Setup error case
        mockNetworkService.mockResult = .failure(NetworkError.invalidURL)
        XCTAssertTrue(viewModel.users.isEmpty, "Users should be empty initially")
        XCTAssertNil(viewModel.errorMessage, "Error message should be nil initially")
        XCTAssertFalse(viewModel.isLoading, "Should not be loading initially")
        
        // When - Fetch users with error
        await viewModel.fetchUsers()
        
        // Then - Verify error state
        XCTAssertFalse(viewModel.isLoading, "Should not be loading after error")
        print(viewModel.errorMessage!)
        XCTAssertEqual(viewModel.errorMessage, NetworkError.invalidURL.localizedDescription, "Should show correct error message")
        XCTAssertTrue(viewModel.users.isEmpty, "Users should be empty after error")
    }
    
}
