***REMOVED***
***REMOVED***  Release.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 08/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import Foundation

struct Release {
    let id: Int

***REMOVED***

extension Release: JSONInitializable {
    init?(json: JSON) {
        guard
            let id = json["id"] as? Int
***REMOVED***            let title = json["title"] as? String,
***REMOVED***            let style = json["style"] as? [String],
***REMOVED***            let country = json["country"] as? String,
***REMOVED***            let format = json["format"] as? [String],
***REMOVED***            let genre = json["genre"] as? [String],
***REMOVED***            let label = json["label"] as? [String],
***REMOVED***            let resourceUrlStr = json["resource_url"] as? String,
***REMOVED***            let resourceUrl = URL(string: resourceUrlStr),
***REMOVED***            let thumbUrlStr = json["thumb"] as? String,
***REMOVED***            let thumb = URL(string: thumbUrlStr),
***REMOVED***            let uri = json["uri"] as? String,
***REMOVED***            let barcode = json["barcode"] as? [String],
***REMOVED***            let catno = json["catno"] as? String
        else {
            return nil
    ***REMOVED***

        self.id = id
***REMOVED***        self.title = title
***REMOVED***        self.style = style
***REMOVED***        self.country = country
***REMOVED***        self.format = format
***REMOVED***        self.genre = genre
***REMOVED***        self.label = label
***REMOVED***        self.resourceUrl = resourceUrl
***REMOVED***        self.thumb = thumb
***REMOVED***        self.uri = uri
***REMOVED***        self.barcode = barcode
***REMOVED***        self.catno = catno
***REMOVED***

***REMOVED***
