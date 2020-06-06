import XCTest
@testable import DefaultsKey

final class DefaultsKeyTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(DefaultsKey().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
