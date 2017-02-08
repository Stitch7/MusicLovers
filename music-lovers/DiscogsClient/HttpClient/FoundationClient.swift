***REMOVED***
***REMOVED***  FoundationClient.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 08/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import Foundation

final class FoundationClient: HttpClient {

    ***REMOVED*** MARK: - Properties

    let baseUrl: URL
    var credentials: Credentials?

    ***REMOVED*** MARK: - Initializers

    init(url: URL, credentials: Credentials? = nil) {
        self.baseUrl = url
        self.credentials = credentials
***REMOVED***

    func load<T>(resource: Resource<T>, completion: @escaping (Result<T>) -> ()) {
        var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false)!

        var path = resource.path
        if false == path.hasPrefix("/") {
            path = "/" + path
    ***REMOVED***
        urlComponents.path = path
        urlComponents.queryItems = resource.queryParameter

        guard let url = urlComponents.url else {
            ***REMOVED*** TODO
            fatalError("Invalid Url")
    ***REMOVED***

        let request = URLRequest(credentials: credentials, url: url, resource: resource)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                error == nil,
                let response = response as? HTTPURLResponse
            else {
                completion(.failure(HttpError.unknown(error)))
                return
        ***REMOVED***

            if false == (200...299 ~= response.statusCode) {
                var message = HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
                if let errorMessage = resource.parseError(data: data) {
                    message =  errorMessage
            ***REMOVED***

                completion(.failure(HttpError.requestFailed(statusCode: response.statusCode, message: message)))
                return
        ***REMOVED***
            
            completion(.success(data.flatMap(resource.parse)))
    ***REMOVED***.resume()
***REMOVED***
***REMOVED***
