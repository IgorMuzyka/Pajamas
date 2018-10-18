import XCTest

import pajamasTests

var tests = [XCTestCaseEntry]()
tests += pajamasTests.__allTests()
XCTMain(tests)
