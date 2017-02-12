//
//  DiscogsClient.swift
//  music-lovers
//
//  Created by Christopher Reitz on 08/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import Foundation

struct DiscogsClient {

    // MARK: - Properties

    let httpClient: HttpClient

    // MARK: - Endpoints

    func search(title: String, completion: @escaping (Result<[SearchItem]>) -> ()) {
        let path = "/database/search"
        let queryParameter = [
            URLQueryItem(name: "release_title", value: title),
            URLQueryItem(name: "title", value: title),
            URLQueryItem(name: "type", value: "release"),
            URLQueryItem(name: "per_page", value: "50"),
            URLQueryItem(name: "page", value: "1")
        ]
        let resource = Resource<[SearchItem]>(path: path, queryParameter: queryParameter, parseJSON: { json in
            guard
                let dictionaries = json as? JSON,
                let results = dictionaries["results"] as? [JSON]
            else { return nil }

            return results.flatMap(SearchItem.init)
        })
        httpClient.load(resource: resource, completion: completion)
    }

    func release(id: Int, completion: @escaping (Result<Release>) -> ()) {
        let path = "/releases/\(id)"
        let resource = Resource<Release>(path: path, parseJSON: { json in
            guard let releaseJson = json as? JSON else { return nil }
            return Release(json: releaseJson)
        })
        httpClient.load(resource: resource, completion: completion)
    }

    func artist(id: Int, completion: @escaping (Result<Artist>) -> ()) {
        let path = "/artists/\(id)"
        let resource = Resource<Artist>(path: path, parseJSON: { json in
            guard let artistJson = json as? JSON else { return nil }
            return Artist(json: artistJson)
        })
        httpClient.load(resource: resource, completion: completion)
    }

    func discography(artistId: Int, completion: @escaping (Result<[Record]>) -> ()) {
        let path = "/artists/\(artistId)/releases"
        let resource = Resource<[Record]>(path: path, parseJSON: { json in
            guard
                let dictionaries = json as? JSON,
                let releases = dictionaries["releases"] as? [JSON]
            else { return nil }

            return releases.flatMap(Record.init)
        })
        httpClient.load(resource: resource, completion: completion)
    }
}
