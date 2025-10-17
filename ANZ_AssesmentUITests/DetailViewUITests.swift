import XCTest

final class DetailViewUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
        
        // Navigate to detail view by tapping first user in the list
        let firstUserCell = app.cells.firstMatch
        XCTAssertTrue(firstUserCell.waitForExistence(timeout: 5))
        firstUserCell.tap()
    }
    
    func testDetailViewElements() throws {
        // Test navigation title exists
        XCTAssertTrue(app.navigationBars.element.exists)
        
        // Test user name exists and is visible
        let nameText = app.staticTexts.matching(identifier: "userName").firstMatch
        XCTAssertTrue(nameText.exists)
        XCTAssertTrue(nameText.isEnabled)
        
        // Test company name exists
        let companyText = app.staticTexts.matching(identifier: "userCompany").firstMatch
        XCTAssertTrue(companyText.exists)
        
        // Test contact info elements exist
//        print("Checking contact info elements...", app.images)
//        print("Checking contact info elements...", app.images["envelope"])
        let emailRow = app.staticTexts.matching(identifier: "emailRow").firstMatch
        XCTAssertTrue(emailRow.exists)
        
        let phoneRow = app.staticTexts.matching(identifier: "phoneRow").firstMatch
        XCTAssertTrue(phoneRow.exists)
        
        let addressRow = app.staticTexts.matching(identifier: "addressRow").firstMatch
        XCTAssertTrue(addressRow.exists)
        
        let countryRow = app.staticTexts.matching(identifier: "countryRow").firstMatch
        XCTAssertTrue(countryRow.exists)
    }
    
    func testScrollingBehavior() throws {
        let scrollView = app.scrollViews.firstMatch
        XCTAssertTrue(scrollView.exists)
        
        // Test scrolling to bottom
        scrollView.swipeUp()
        
        // Test scrolling back to top
        scrollView.swipeDown()
    }
    
    func testImageLoading() throws {
        // Wait for image to load (progress view should disappear)
        let progressView = app.activityIndicators.firstMatch
        XCTAssertFalse(progressView.exists, "Progress view should not be visible after image loads")
    }
}
