//
//  DoubleExtensionTest.swift
//  iTunesSearchTests
//
//  Created by Cory Skelly on 11/16/20.
//

import XCTest

class DoubleExtensionTest: XCTestCase {

    func testDoubleToString() throws {
        XCTAssertEqual(Double(1.99).toString(), "1.99")
        XCTAssertEqual(Double(1.9).toString(), "1.90")
        XCTAssertEqual(Double(0.99).toString(), "0.99")
        XCTAssertEqual(Double(1).toString(), "1.00")
    }
}
