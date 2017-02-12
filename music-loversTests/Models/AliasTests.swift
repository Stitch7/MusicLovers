//
//  AliasTests.swift
//  music-lovers
//
//  Created by Christopher Reitz on 12/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import XCTest
@testable import music_lovers

class AliasTests: XCTestCase {

    // MARK: - Stubs

    var validJson: JSON {
        var json = JSON()
        json["id"] = 42
        json["name"] = "Beginner"
        json["resource_url"] = "https://example.org"
        return json
    }

    // MARK: - Tests

    func testInitWithValidJSON() {
        let alias = Alias(json: validJson)
        XCTAssertNotNil(alias)
    }

    func testInitWithInvalidJSON() {
        var invalidJson = validJson
        invalidJson["id"] = "42"

        let alias = Alias(json: invalidJson)
        XCTAssertNil(alias)
    }
}
