***REMOVED***
***REMOVED***  Track.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 08/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import Foundation

struct Track {
    let position: String
    let title: String
    let duration: String
    let extraArtists: [Artist]
***REMOVED***

extension Track: JSONInitializable {
    init?(json: JSON) {
        guard
            let position = json["position"] as? String,
            let title = json["title"] as? String,
            let duration = json["duration"] as? String,
            let extraArtistsJson = json["extraartists"] as? [JSON]
        else {
            return nil
    ***REMOVED***

        self.position = position
        self.title = title
        self.duration = duration
        self.extraArtists = extraArtistsJson.flatMap(Artist.init)
***REMOVED***
***REMOVED***
