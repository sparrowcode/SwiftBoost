import XCTest
@testable import SparrowKit

final class SparrowKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SparrowKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
