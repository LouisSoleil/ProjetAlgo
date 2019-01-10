import XCTest

import TypeTests

var tests = [XCTestCaseEntry]()
tests += TypeTests.allTests()
XCTMain(tests)