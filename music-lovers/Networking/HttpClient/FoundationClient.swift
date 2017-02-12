//
//  FoundationClient.swift
//  music-lovers
//
//  Created by Christopher Reitz on 08/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import Foundation

final class FoundationClient: HttpClient {

    // MARK: - Properties

    let baseUrl: URL
    var credentials: Credentials?

    // MARK: - Initializers

    init(url: URL, credentials: Credentials? = nil) {
        self.baseUrl = url
        self.credentials = credentials
    }

    func load<T>(resource: Resource<T>, completion: @escaping (Result<T>) -> ()) {
        var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false)!

        var path = resource.path
        if !path.hasPrefix("/") {
            path = "/" + path
        }
        urlComponents.path = path
        urlComponents.queryItems = resource.queryParameter

        guard let url = urlComponents.url else {
            completion(.failure(HttpError.invalidUrl))
            return
        }

        var request = URLRequest(url: url, resource: resource)
        if resource.needsAuth {
            if let creds = credentials {
                request.setValue("Discogs key=\(creds.key), secret=\(creds.secret)", forHTTPHeaderField: "Authorization")
            }
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                error == nil,
                let response = response as? HTTPURLResponse
            else {
                completion(.failure(HttpError.unknown(error)))
                return
            }

            if false == (200...299 ~= response.statusCode) {
                var message = HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
                if let errorMessage = resource.parseError(data: data) {
                    message =  errorMessage
                }

                completion(.failure(HttpError.requestFailed(statusCode: response.statusCode, message: message)))
                return
            }
            
            completion(.success(data.flatMap(resource.parse)))
        }.resume()
    }
}
