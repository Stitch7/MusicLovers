//
//  FormatTests.swift
//  music-lovers
//
//  Created by Christopher Reitz on 12/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import XCTest
@testable import music_lovers

class FormatTests: XCTestCase {

    // MARK: - Stubs

    var validJson: JSON {
        var json = JSON()
        json["descriptions"] = ["CD", "LP"]
        json["name"] = "Füchse"
        json["qty"] = "8"
        return json
    }

    // MARK: - Tests

    func testInitWithValidJSON() {
        let format = Format(json: validJson)
        XCTAssertNotNil(format)
    }

    func testInitWithInvalidJSON() {
        var invalidJson = validJson
        invalidJson["qty"] = 8

        let format = Format(json: invalidJson)
        XCTAssertNil(format)
    }
}
