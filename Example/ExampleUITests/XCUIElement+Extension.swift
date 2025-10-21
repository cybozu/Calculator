import XCTest

extension XCUIElement {
    @MainActor
    func wait<V>(
        for keyPath: KeyPath<XCUIElement, V>,
        toEqual expectedValue: V,
        timeout: TimeInterval = 5.0,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self where V: Equatable {
        XCTAssertTrue(wait(for: keyPath, toEqual: expectedValue, timeout: timeout), file: file, line: line)
        return self
    }
}
