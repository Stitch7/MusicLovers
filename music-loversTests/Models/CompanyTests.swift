//
//  CompanyTests.swift
//  music-lovers
//
//  Created by Christopher Reitz on 12/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import XCTest
@testable import music_lovers

class CompanyTests: XCTestCase {

    // MARK: - Stubs

    var validJson: JSON {
        var json = JSON()
        json["id"] = 42
        json["name"] = "Neofonie"
        json["resource_url"] = "https://example.org"
        json["cat_no"] = "007"
        json["entity_type"] = "Foo"
        json["entity_type_name"] = "Bar"
        return json
    }

    // MARK: - Tests

    func testInitWithValidJSON() {
        let company = Company(json: validJson)
        XCTAssertNotNil(company)
    }

    func testInitWithInvalidJSON() {
        var invalidJson = validJson
        invalidJson["id"] = "42"

        let company = Company(json: invalidJson)
        XCTAssertNil(company)
    }
}
