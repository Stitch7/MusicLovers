//
//  Track.swift
//  music-lovers
//
//  Created by Christopher Reitz on 08/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import Foundation

struct Track {
    let position: String
    let title: String
    let duration: String
    let extraArtists: [Artist]?
}

extension Track: JSONInitializable {
    init?(json: JSON) {
        guard
            let position = json["position"] as? String,
            let title = json["title"] as? String,
            let duration = json["duration"] as? String
        else {
            return nil
        }

        self.position = position
        self.title = title
        self.duration = duration

        var extraArtists: [Artist]? = nil
        if let extraArtistsJson = json["extraartists"] as? [JSON] {
            extraArtists = extraArtistsJson.flatMap(Artist.init)
        }
        self.extraArtists = extraArtists
    }
}
