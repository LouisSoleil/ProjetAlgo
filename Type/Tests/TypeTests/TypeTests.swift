import XCTest
@testable import Type

final class TypeTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Type().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
