//
//  IdentifierTests.swift
//  music-lovers
//
//  Created by Christopher Reitz on 12/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import XCTest
@testable import music_lovers

class IdentifierTests: XCTestCase {

    // MARK: - Stubs

    var validJson: JSON {
        var json = JSON()
        json["type"] = "Type"
        json["value"] = "Value"
        return json
    }

    // MARK: - Tests

    func testInitWithValidJSON() {
        let identifier = Identifier(json: validJson)
        XCTAssertNotNil(identifier)
    }

    func testInitWithInvalidJSON() {
        var invalidJson = validJson
        invalidJson.removeValue(forKey: "type")

        let identifier = Identifier(json: invalidJson)
        XCTAssertNil(identifier)
    }
}
