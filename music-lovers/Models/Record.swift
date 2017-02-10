***REMOVED***
***REMOVED***  Record.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 10/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import Foundation

struct Record {
    let id: Int
    let title: String
    let artist: String
    let format: String
    let label: String
    let resourceUrl: URL
    let role: String
    let status: String
    let thumb: URL
    let type: String
    let year: Int
***REMOVED***
extension Record: JSONInitializable {
    init?(json: JSON) {
        guard
            let id = json["id"] as? Int,
            let title = json["title"] as? String,
            let artist = json["artist"] as? String,
            let format = json["format"] as? String,
            let label = json["label"] as? String,
            let resourceUrlStr = json["resource_url"] as? String,
            let resourceUrl = URL(string: resourceUrlStr),
            let role = json["role"] as? String,
            let status = json["status"] as? String,
            let thumbUrlStr = json["thumb"] as? String,
            let thumb = URL(string: thumbUrlStr),
            let type = json["type"] as? String,
            let year = json["year"] as? Int
        else {
            return nil
    ***REMOVED***

        self.id = id
        self.title = title
        self.artist = artist
        self.format = format
        self.label = label
        self.resourceUrl = resourceUrl
        self.role = role
        self.status = status
        self.thumb = thumb
        self.type = type
        self.year = year
***REMOVED***
***REMOVED***
