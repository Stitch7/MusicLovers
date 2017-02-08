***REMOVED***
***REMOVED***  HttpClient.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 08/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import Foundation

protocol HttpClient {
    var baseUrl: URL { get ***REMOVED***
    var credentials: Credentials? { get set ***REMOVED***
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T>) -> ())
***REMOVED***

extension URLRequest {
    init<T>(credentials: Credentials?, url: URL, resource: Resource<T>) {
        self.init(url: url)

        if resource.needsAuthentication {
            if let creds = credentials {
                setValue("Discogs key=\(creds.key), secret=\(creds.secret)", forHTTPHeaderField: "Authorization")
        ***REMOVED***
    ***REMOVED***

        httpMethod = resource.method.string
        if case let .post(data) = resource.method {
            httpBody = data
    ***REMOVED***
***REMOVED***
***REMOVED***
