import XCTest

import displayMainTests

var tests = [XCTestCaseEntry]()
tests += displayMainTests.allTests()
XCTMain(tests)