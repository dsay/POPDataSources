import XCTest
@testable import POPDataSource

final class POPDataSourceTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(POPDataSource().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
