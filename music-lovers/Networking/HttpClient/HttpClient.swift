//
//  HttpClient.swift
//  music-lovers
//
//  Created by Christopher Reitz on 08/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import Foundation

protocol HttpClient {
    var baseUrl: URL { get }
    var credentials: Credentials? { get set }
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T>) -> ())
}

extension URLRequest {
    init<T>(url: URL, resource: Resource<T>) {
        self.init(url: url)

        httpMethod = resource.method.string
        if case let .post(data) = resource.method {
            httpBody = data
        }
    }
}
