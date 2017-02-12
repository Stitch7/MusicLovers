//
//  TestClient.swift
//  music-lovers
//
//  Created by Christopher Reitz on 12/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import Foundation

@testable import music_lovers

class TestClient: HttpClient {

    let baseUrl = URL(string: "https://example.org")!
    var credentials: Credentials?

    let responseData: Data?

    init(responseData: Data? = nil) {
        self.responseData = responseData
    }

    func load<T>(resource: Resource<T>, completion: @escaping (Result<T>) -> ()) {
        completion(.success(responseData.flatMap(resource.parse)))
    }
}
