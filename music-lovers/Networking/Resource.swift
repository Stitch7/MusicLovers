***REMOVED***
***REMOVED***  Resource.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 08/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import Foundation

struct Resource<T> {
    let path: String
    let queryParameter: [URLQueryItem]?
    let needsAuthentication: Bool
    let method: HttpMethod<Data>
    let parse: (Data) -> T?
    func parseError(data: Data?) -> String? {
        let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as? [String: String]
        return json??["error"]
***REMOVED***
***REMOVED***

extension Resource {
    init(path: String, queryParameter: [URLQueryItem]? = nil, needsAuthentication: Bool = false, method: HttpMethod<Any> = .get, parseJSON: @escaping (Any) -> T?) {
        self.path = path
        self.queryParameter = queryParameter
        self.needsAuthentication = needsAuthentication
        self.method = method.map { json in
            try! JSONSerialization.data(withJSONObject: json, options: [])
    ***REMOVED***
        self.parse = { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
            return json.flatMap(parseJSON)
    ***REMOVED***
***REMOVED***
***REMOVED***
