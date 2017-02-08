***REMOVED***
***REMOVED***  Artist.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 08/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import Foundation

struct Artist {
    let id: Int
    let name: String
    let resourceUrl: URL
***REMOVED***

extension Artist: JSONInitializable {
    init?(json: JSON) {
        guard
            let id = json["id"] as? Int,
            let name = json["name"] as? String,
            let resourceUrlStr = json["resource_url"] as? String,
            let resourceUrl = URL(string: resourceUrlStr)
        else {
            return nil
    ***REMOVED***

        self.id = id
        self.name = name
        self.resourceUrl = resourceUrl
***REMOVED***
***REMOVED***
