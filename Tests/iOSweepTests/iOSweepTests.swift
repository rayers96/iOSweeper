import XCTest
@testable import iOSweep

final class iOSweepTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(iOSweep().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
