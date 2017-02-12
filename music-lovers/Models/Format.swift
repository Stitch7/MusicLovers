//
//  Format.swift
//  music-lovers
//
//  Created by Christopher Reitz on 08/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

struct Format {
    let descriptions: [String]
    let name: String
    let qty: String
}

extension Format: JSONInitializable {
    init?(json: JSON) {
        guard
            let descriptions = json["descriptions"] as? [String],
            let name = json["name"] as? String,
            let qty = json["qty"] as? String
        else {
            return nil
        }

        self.descriptions = descriptions
        self.name = name
        self.qty = qty
    }
}
