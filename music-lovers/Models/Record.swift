//
//  Record.swift
//  music-lovers
//
//  Created by Christopher Reitz on 10/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import Foundation

struct Record {
    let id: Int
    let title: String
    let artist: String
    let resourceUrl: URL
    let thumb: URL
    let type: String
    let year: Int

    let label: String?
    let format: String?
    let role: String?
    let status: String?
}
extension Record: JSONInitializable {
    init?(json: JSON) {
        guard
            let id = json["id"] as? Int,
            let title = json["title"] as? String,
            let artist = json["artist"] as? String,
            let resourceUrlStr = json["resource_url"] as? String,
            let resourceUrl = URL(string: resourceUrlStr),
            let thumbUrlStr = json["thumb"] as? String,
            let thumb = URL(string: thumbUrlStr),
            let type = json["type"] as? String,
            let year = json["year"] as? Int
        else {
            return nil
        }

        self.id = id
        self.title = title
        self.artist = artist
        self.resourceUrl = resourceUrl
        self.thumb = thumb
        self.type = type
        self.year = year

        self.label = json["label"] as? String
        self.format = json["format"] as? String
        self.role = json["role"] as? String
        self.status = json["status"] as? String
    }
}
