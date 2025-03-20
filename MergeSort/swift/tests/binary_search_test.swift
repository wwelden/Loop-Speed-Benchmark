import XCTest
@testable import BinarySearch

final class BinarySearchTests: XCTestCase {
    func testTargetInMiddle() {
        let arr = [1, 2, 3, 4, 5]
        XCTAssertEqual(binarySearch(arr, target: 3), 2)
    }

    func testTargetAtStart() {
        let arr = [1, 2, 3, 4, 5]
        XCTAssertEqual(binarySearch(arr, target: 1), 0)
    }

    func testTargetAtEnd() {
        let arr = [1, 2, 3, 4, 5]
        XCTAssertEqual(binarySearch(arr, target: 5), 4)
    }

    func testTargetNotPresent() {
        let arr = [1, 2, 3, 4, 5]
        XCTAssertNil(binarySearch(arr, target: 6))
    }

    func testEmptyArray() {
        let arr: [Int] = []
        XCTAssertNil(binarySearch(arr, target: 1))
    }

    func testSingleElement() {
        let arr = [1]
        XCTAssertEqual(binarySearch(arr, target: 1), 0)
    }

    func testNegativeNumbers() {
        let arr = [-5, -3, -1, 0, 2]
        XCTAssertEqual(binarySearch(arr, target: -3), 1)
    }

    func testDuplicateElements() {
        let arr = [1, 2, 2, 2, 3]
        XCTAssertEqual(binarySearch(arr, target: 2), 1)
    }

    func testStringArray() {
        let arr = ["apple", "banana", "cherry", "date", "elderberry"]
        XCTAssertEqual(binarySearch(arr, target: "cherry"), 2)
        XCTAssertEqual(binarySearch(arr, target: "apple"), 0)
        XCTAssertEqual(binarySearch(arr, target: "elderberry"), 4)
        XCTAssertNil(binarySearch(arr, target: "fig"))
    }
}
