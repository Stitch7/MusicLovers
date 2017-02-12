//
//  String+leftPaddingTests.swift
//  music-lovers
//
//  Created by Christopher Reitz on 12/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import XCTest

@testable import music_lovers

class StringLeftPaddingTests: XCTestCase {
    func testPadding() {
        let padded = "7".leftPadding(toLength: 3, withPad: "0")
        XCTAssertEqual(padded, "007")
    }

    func testIfOnlyPaddingIfNecessary() {
        let base = "007"
        let padded = base.leftPadding(toLength: 3, withPad: "0")
        XCTAssertEqual(base, padded)
    }
}
