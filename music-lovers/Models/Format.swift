***REMOVED***
***REMOVED***  Format.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 08/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

struct Format {
    let descriptions: [String]
    let name: String
    let qty: String
***REMOVED***

extension Format: JSONInitializable {
    init?(json: JSON) {
        guard
            let descriptions = json["descriptions"] as? [String],
            let name = json["name"] as? String,
            let qty = json["qty"] as? String
        else {
            return nil
    ***REMOVED***

        self.descriptions = descriptions
        self.name = name
        self.qty = qty
***REMOVED***
***REMOVED***
