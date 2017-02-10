***REMOVED***
***REMOVED***  Identifier.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 08/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

struct Identifier {
    let type: String
    let value: String
***REMOVED***

extension Identifier: JSONInitializable {
    init?(json: JSON) {
        guard
            let type = json["type"] as? String,
            let value = json["value"] as? String
        else {
            return nil
    ***REMOVED***

        self.type = type
        self.value = value
***REMOVED***
***REMOVED***
