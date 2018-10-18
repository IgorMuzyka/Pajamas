import XCTest

extension PajamasTests {
    static let __allTests = {
        PajamasTests.allTests
    }
}

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(PajamasTests.__allTests),
    ]
}
#endif
