//
//  DiscogsClientTests.swift
//  music-lovers
//
//  Created by Christopher Reitz on 12/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import Foundation
import XCTest

@testable import music_lovers

class DiscogsClientTests: XCTestCase {

    // MARK: - Helper

    func responseStub(name: String) -> Data {
        guard
            let file = Bundle(for: type(of: self)).path(forResource: "\(name)Response", ofType: "json"),
            let searchResponseStr = try? String(contentsOfFile: file, encoding: .utf8),
            let searchResponseJson = searchResponseStr.data(using: .utf8)
        else {
            fatalError("File \(name).json not found in test bundle")
        }

        return searchResponseJson
    }

    // MARK: - Tests
    
    func testSearch() {
        let json = responseStub(name: "search")
        let testClient = TestClient(responseData: json)
        let discogsClient = DiscogsClient(httpClient: testClient)

        discogsClient.search(title: "Bambule") { result in
            switch result {
            case .success(let items):
                let count = items?.count ?? 0
                XCTAssertGreaterThan(count, 0)
            case .failure:
                XCTAssertTrue(false)
            }
        }
    }

    func testRelease() {
        let json = responseStub(name: "release")
        let testClient = TestClient(responseData: json)
        let discogsClient = DiscogsClient(httpClient: testClient)

        discogsClient.release(id: 534832) { result in
            switch result {
            case .success(let release):
                XCTAssertNotNil(release)
            case .failure:
                XCTAssertTrue(false)
            }
        }
    }

    func testArtist() {
        let json = responseStub(name: "artist")
        let testClient = TestClient(responseData: json)
        let discogsClient = DiscogsClient(httpClient: testClient)

        discogsClient.artist(id: 67095) { result in
            switch result {
            case .success(let release):
                XCTAssertNotNil(release)
            case .failure:
                XCTAssertTrue(false)
            }
        }
    }

    func testDiscography() {
        let json = responseStub(name: "discography")
        let testClient = TestClient(responseData: json)
        let discogsClient = DiscogsClient(httpClient: testClient)

        discogsClient.discography(artistId: 67095) { result in
            switch result {
            case .success(let records):
                let count = records?.count ?? 0
                XCTAssertGreaterThan(count, 0)
            case .failure:
                XCTAssertTrue(false)
            }
        }
    }
}
