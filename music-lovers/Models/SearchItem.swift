//
//  SearchItem.swift
//  music-lovers
//
//  Created by Christopher Reitz on 08/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import Foundation

struct SearchItem {
    let id: Int
    let title: String
    let style: [String]
    let country: String
    let format: [String]
    let genre: [String]
    let label: [String]
    let resourceUrl: URL
    let thumb: URL
    let uri: String
    let barcode: [String]
    let catno: String
    let year: String
}

extension SearchItem: JSONInitializable {
    init?(json: JSON) {
        guard
            let id = json["id"] as? Int,
            let title = json["title"] as? String,
            let style = json["style"] as? [String],
            let country = json["country"] as? String,
            let format = json["format"] as? [String],
            let genre = json["genre"] as? [String],
            let label = json["label"] as? [String],
            let resourceUrlStr = json["resource_url"] as? String,
            let resourceUrl = URL(string: resourceUrlStr),
            let thumbUrlStr = json["thumb"] as? String,
            let thumb = URL(string: thumbUrlStr),
            let uri = json["uri"] as? String,
            let barcode = json["barcode"] as? [String],
            let catno = json["catno"] as? String,
            let year = json["year"] as? String
        else {
            return nil
        }

        self.id = id
        self.title = title
        self.style = style
        self.country = country
        self.format = format
        self.genre = genre
        self.label = label
        self.resourceUrl = resourceUrl
        self.thumb = thumb
        self.uri = uri
        self.barcode = barcode
        self.catno = catno
        self.year = year
    }
}
