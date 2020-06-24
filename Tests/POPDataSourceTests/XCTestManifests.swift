import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(POPDataSourceTests.allTests),
    ]
}
#endif
