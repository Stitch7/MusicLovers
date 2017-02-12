//
//  SearchItemTests.swift
//  music-lovers
//
//  Created by Christopher Reitz on 12/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import XCTest
@testable import music_lovers

class SearchItemTests: XCTestCase {

    // MARK: - Stubs

    var validJson: JSON {
        var json = JSON()
        json["id"] = 42
        json["title"] = "Füchse"
        json["style"] = ["derb"]
        json["country"] = "Germany"
        json["format"] = ["CD", "LP"]
        json["genre"] = ["HipHop", "Rap"]
        json["label"] = ["Universal", ""]
        json["resource_url"] = "https://example.org"
        json["thumb"] = "https://example.org"
        json["uri"] = "https://example.org"
        json["barcode"] = ["ABC", "123"]
        json["catno"] = "007"
        json["year"] = "1984"
        return json
    }

    // MARK: - Tests

    func testInitWithValidJSON() {
        let searchItem = SearchItem(json: validJson)
        XCTAssertNotNil(searchItem)
    }

    func testInitWithInvalidJSON() {
        var invalidJson = validJson
        invalidJson["id"] = "42"

        let searchItem = SearchItem(json: invalidJson)
        XCTAssertNil(searchItem)
    }
}
