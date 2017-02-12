//
//  Resource.swift
//  music-lovers
//
//  Created by Christopher Reitz on 08/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import Foundation

struct Resource<T> {
    let path: String
    let queryParameter: [URLQueryItem]?
    let needsAuth: Bool
    let method: HttpMethod<Data>
    let parse: (Data) -> T?

    func parseError(data: Data?) -> String? {
        let defaultOptions = JSONSerialization.ReadingOptions()
        let json = try? JSONSerialization.jsonObject(with: data!, options: defaultOptions) as? [String: String]
        return json??["error"]
    }
}

extension Resource {
    init(path: String,
         queryParameter: [URLQueryItem]? = nil,
         needsAuth: Bool = true,
         method: HttpMethod<Any> = .get,
         parseJSON: @escaping (Any) -> T?
    ) {
        self.path = path
        self.queryParameter = queryParameter
        self.needsAuth = needsAuth
        self.method = method.map { json in
            try! JSONSerialization.data(withJSONObject: json, options: [])
        }
        self.parse = { data in
            let defaultOptions = JSONSerialization.ReadingOptions()
            let json = try? JSONSerialization.jsonObject(with: data, options: defaultOptions)
            return json.flatMap(parseJSON)
        }
    }
}
