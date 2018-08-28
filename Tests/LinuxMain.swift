import XCTest

import pajamasTests

var tests = [XCTestCaseEntry]()
tests += pajamasTests.allTests()
XCTMain(tests)