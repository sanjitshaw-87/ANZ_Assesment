# ANZ Assessment iOS App

A SwiftUI-based iOS application that demonstrates modern iOS development practices, clean architecture, and robust testing.

## Architecture & Design Patterns

### MVVM (Model-View-ViewModel)
The application follows the MVVM architectural pattern:
- **Models**: Data models like `User` that represent the core data structures
- **Views**: SwiftUI views (`UserListView`, `DetailView`, `RowView`) that handle the UI representation
- **ViewModels**: `ItemsViewModel` that manages the business logic and data state

### Key Components

#### Views
- `UserListView`: Main list view displaying user entries
- `DetailView`: Detailed view for individual user information
- `RowView`: Reusable component for list items

#### Services
- `NetworkService`: Handles network requests with async/await
- `DataParser`: Generic JSON parsing service

#### Design Patterns
- **Dependency Injection**: Services are injected through protocols
- **Protocol-Oriented Programming**: Using protocols for NetworkService and DataParser
- **Observer Pattern**: Using SwiftUI's @Published for reactive updates
- **Repository Pattern**: Abstraction of data access through NetworkService

## Features

- Asynchronous image loading with loading states
- Error handling and user feedback
- Multiline text support for various screen sizes
- Responsive layout using SwiftUI's layout system
- Accessibility support with identifiers

## Testing

The project follows a comprehensive testing strategy with clear segregation between different types of tests. The project uses separate schemes for UI Tests and Unit Tests to allow independent execution and better CI/CD integration.

### Test Schemes

#### 1. ANZ_AssesmentTests Scheme
Dedicated scheme for running unit tests:
- Faster execution (~2-5 seconds)
- No UI component initialization
- Can be run without simulator
- Ideal for CI/CD pipelines
- **Scheme Configuration**:
  - Build Configuration: Debug
  - Test Coverage: Enabled
  - Parallel Testing: Enabled
  - Environment Variables:
    ```
    IS_UNIT_TESTING=YES
    MOCK_NETWORK_ENABLED=YES
    ```
  - Launch Arguments:
    ```
    -unittest YES
    ```
- **Included Tests**:
  - ViewModel tests
  - Model tests
  - Network service tests
  - Parser tests
  - Constants validation

#### 2. ANZ_AssesmentUITests Scheme
Separate scheme for UI testing:
- Requires simulator
- Takes longer to execute (~30 seconds)
- Tests real user interactions
- **Scheme Configuration**:
  - Build Configuration: Debug
  - Screenshots: Enabled
  - Performance Metrics: Enabled
  - Environment Variables:
    ```
    IS_UI_TESTING=YES
    MOCK_NETWORK_DELAY=2
    ```
  - Launch Arguments:
    ```
    -ui_testing YES
    -AppleLanguages (en)
    -AppleLocale en_US
    ```
- **Included Tests**:
  - Navigation flow tests
  - Detail view tests
  - List view tests
  - Accessibility tests

### Scheme Setup Instructions

#### Setting Up Unit Test Scheme
1. In Xcode, go to Product > Scheme > Edit Scheme
2. Select "Test" from the left sidebar
3. Click "+" to add a new test target
4. Select only "ANZ_AssesmentTests"
5. Under Options:
   - Enable code coverage
   - Check "Randomize execution order"
   - Set "Test Execution" to "Parallel"
6. Under Arguments:
   - Add the environment variables listed above
   - Add the launch arguments listed above

#### Setting Up UI Test Scheme
1. In Xcode, go to Product > Scheme > Edit Scheme
2. Select "Test" from the left sidebar
3. Click "+" to add a new test target
4. Select only "ANZ_AssesmentUITests"
5. Under Options:
   - Enable "Gather system trace data"
   - Set "Test Execution" to "Serial"
6. Under Arguments:
   - Add the environment variables listed above
   - Add the launch arguments listed above

### Test Categories and Organization

#### 1. Unit Tests (`ANZ_AssesmentTests/`)
##### ItemsViewModel Tests
- **Success Scenarios**
  - Fetching users successfully
  - Empty response handling
  - Data transformation
- **Error Scenarios**
  - Network errors
  - Invalid data handling
  - Timeout handling
- **State Management**
  - Loading state transitions
  - Error message updates
  - Users array updates

##### Model Tests
- **UserTests**
  - Model initialization
  - Property validation
  - Data consistency

##### Service Tests
- **DataParserTests**
  - Success case parsing
  - Error handling
  - Edge cases

#### 2. UI Tests (`ANZ_AssesmentUITests/`)
##### DetailView Tests
- Screen element verification
- Layout adaptation tests
- Interaction tests
  - Scrolling behavior
  - Navigation
  - Image loading states
- Accessibility validation

##### UserList Tests
- List scrolling performance
- Item interaction
- Pull-to-refresh behavior
- Error state UI

### Test Execution Guide

#### Running Tests by Scheme
```bash
# Run Unit Tests Only
1. Select ANZ_AssesmentTests scheme
2. CMD + U or Product > Test

# Run UI Tests Only
1. Select ANZ_AssesmentUITests scheme
2. CMD + U or Product > Test

# Run from Terminal
# Unit Tests
xcodebuild test -scheme ANZ_AssesmentTests -destination 'platform=iOS Simulator,name=iPhone 15,OS=17.0'

# UI Tests
xcodebuild test -scheme ANZ_AssesmentUITests -destination 'platform=iOS Simulator,name=iPhone 15,OS=17.0'
```

#### CI/CD Integration
The separate schemes enable efficient CI/CD workflows:
1. **Fast Feedback Loop**:
   - Unit tests run on every pull request
   - Quick validation of business logic changes

2. **UI Test Strategy**:
   - UI tests run on specific branches only
   - Scheduled nightly runs
   - Pre-release validation

3. **Parallel Execution**:
   - Unit and UI tests can run simultaneously
   - Faster overall build times

#### Test Configurations
1. **Unit Tests Scheme**
   - Mock network layer enabled
   - In-memory data storage
   - Synchronous operations where possible
   - Coverage reporting enabled

2. **UI Tests Scheme**
   - Mock backend responses
   - Network request delay simulation
   - Screenshot capture enabled
   - Performance metrics gathering

### Mock Components
- **MockNetworkService**
  - Configurable responses
  - Controlled error scenarios
  - Customizable delays
- **MockData.json**
  - Sample user data
  - Edge case scenarios
  - Different data formats

### Test Prerequisites
- Clean build required before running tests
- Simulator with iOS 15.0+ for UI tests
- Mock data files must be included in test target

## Technical Details

### Swift Features Used
- Async/await for concurrent operations
- SwiftUI for declarative UI
- Property wrappers (@Published, @MainActor)
- Generic protocols for reusable components

### Best Practices
- Clean code architecture
- Separation of concerns
- Proper error handling
- Comprehensive test coverage
- Accessibility implementation
- Responsive design principles

## Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.5+

## Project Structure

```
ANZ_Assesment/
├── Models/
│   └── User.swift
├── Views/
│   ├── UserListView.swift
│   ├── DetailView.swift
│   └── RowView.swift
├── ViewModels/
│   └── ItemsViewModel.swift
├── Services/
│   ├── NetworkService.swift
│   └── DataParser.swift
└── Utils/
    └── Constants.swift

Tests/
├── Unit Tests/
│   └── ItemsViewModelTests.swift
├── UI Tests/
│   └── DetailViewUITests.swift
└── Mocks/
    └── MockNetworkService.swift
```

## Getting Started

1. Clone the repository
2. Open `ANZ_Assesment.xcodeproj` in Xcode
3. Build and run the project

## Running Tests

1. Open the project in Xcode
2. Select the test navigator
3. Click the play button next to the test suite
4. Or use CMD+U to run all tests
