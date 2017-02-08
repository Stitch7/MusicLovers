***REMOVED***
***REMOVED***  Video.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 08/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import Foundation

struct Video {
    let title: String
    let description: String
    let duration: Int
    let embed: Bool
    let uri: URL
***REMOVED***

extension Video: JSONInitializable {
    init?(json: JSON) {
        guard
            let title = json["title"] as? String,
            let description = json["description"] as? String,
            let duration = json["duration"] as? Int,
            let embed = json["embed"] as? Bool,
            let uriStr = json["uri"] as? String,
            let uri = URL(string: uriStr)
        else {
            return nil
    ***REMOVED***

        self.title = title
        self.description = description
        self.duration = duration
        self.embed = embed
        self.uri = uri
***REMOVED***
***REMOVED***
