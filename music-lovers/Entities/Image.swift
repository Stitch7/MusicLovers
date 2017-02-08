***REMOVED***
***REMOVED***  Image.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 08/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import Foundation

struct Image {
    let type: String
    let width: Int
    let height: Int
    let resourceUrl: URL
    let uri: URL
    let uri150: URL
***REMOVED***

extension Image: JSONInitializable {
    init?(json: JSON) {
        guard
            let type = json["type"] as? String,
            let width = json["width"] as? Int,
            let height = json["height"] as? Int,
            let resourceUrlStr = json["resource_url"] as? String,
            let resourceUrl = URL(string: resourceUrlStr),
            let uriStr = json["uri"] as? String,
            let uri = URL(string: uriStr),
            let uri150Str = json["uri150"] as? String,
            let uri150 = URL(string: uri150Str)
        else {
            return nil
    ***REMOVED***

        self.type = type
        self.width = width
        self.height = height
        self.resourceUrl = resourceUrl
        self.uri = uri
        self.uri150 = uri150
***REMOVED***
***REMOVED***
