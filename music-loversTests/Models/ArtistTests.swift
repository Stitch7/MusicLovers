//
//  ArtistTests.swift
//  music-lovers
//
//  Created by Christopher Reitz on 12/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import XCTest
@testable import music_lovers

class ArtistTests: XCTestCase {

    // MARK: - Stubs

    var validJson: JSON {
        var json = JSON()
        json["id"] = 42
        json["name"] = "Absolute Beginner"
        json["resource_url"] = "https://example.org"

        json["role"] = "Lead"
        // images
        json["profile"] = "Derbste Band aus Hamburg"
        // aliases
        // members
        json["namevariations"] = ["Beginner", "AB"]
        json["urls"] = [URL(string: "https://example.org")!]
        return json
    }

    // MARK: - Tests

    func testInitWithValidJSON() {
        let artist = Artist(json: validJson)
        XCTAssertNotNil(artist)
    }

    func testInitWithInvalidJSON() {
        var invalidJson = validJson
        invalidJson["id"] = "42"

        let artist = Artist(json: invalidJson)
        XCTAssertNil(artist)
    }
}
