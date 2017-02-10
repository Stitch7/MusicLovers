***REMOVED***
***REMOVED***  DiscogsClient.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 08/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import Foundation

struct DiscogsClient {

    ***REMOVED*** MARK: - Properties

    let httpClient: HttpClient

    ***REMOVED*** MARK: - Endpoints

    func search(title: String, completion: @escaping (Result<[SearchItem]>) -> ()) {
        let path = "/database/search"
        let queryParameter = [
            URLQueryItem(name: "title", value: title),
            URLQueryItem(name: "per_page", value: "50"),
            URLQueryItem(name: "page", value: "1")
        ]
        let resource = Resource<[SearchItem]>(path: path, queryParameter: queryParameter, parseJSON: { json in
            guard
                let dictionaries = json as? JSON,
                let results = dictionaries["results"] as? [JSON]
            else { return nil ***REMOVED***

            return results.flatMap(SearchItem.init)
    ***REMOVED***)
        httpClient.load(resource: resource, completion: completion)
***REMOVED***

    func release(id: Int, completion: @escaping (Result<Release>) -> ()) {
        let path = "/releases/\(id)"
        let queryParameter: [URLQueryItem]? = nil
        let resource = Resource<Release>(path: path, queryParameter: queryParameter, parseJSON: { json in
            guard let releaseJson = json as? JSON else { return nil ***REMOVED***
            return Release(json: releaseJson)
    ***REMOVED***)
        httpClient.load(resource: resource, completion: completion)
***REMOVED***

    func artist(id: Int, completion: @escaping (Result<Artist>) -> ()) {
        let path = "/artists/\(id)"
        let queryParameter: [URLQueryItem]? = nil
        let resource = Resource<Artist>(path: path, queryParameter: queryParameter, parseJSON: { json in
            guard let artistJson = json as? JSON else { return nil ***REMOVED***
            return Artist(json: artistJson)
    ***REMOVED***)
        httpClient.load(resource: resource, completion: completion)
***REMOVED***

    func discography(artistId: Int, completion: @escaping (Result<[Record]>) -> ()) {
        let path = "/artists/\(artistId)/releases"
        let queryParameter: [URLQueryItem]? = nil
        let resource = Resource<[Record]>(path: path, queryParameter: queryParameter, parseJSON: { json in
            guard
                let dictionaries = json as? JSON,
                let releases = dictionaries["releases"] as? [JSON]
            else { return nil ***REMOVED***

            return releases.flatMap(Record.init)
    ***REMOVED***)
        httpClient.load(resource: resource, completion: completion)
***REMOVED***
***REMOVED***
