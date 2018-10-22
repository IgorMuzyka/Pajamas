import XCTest

import PajamasTests

var tests = [XCTestCaseEntry]()
tests += pajamasTests.__allTests()
XCTMain(tests)
