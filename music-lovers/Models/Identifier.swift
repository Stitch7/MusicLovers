//
//  Identifier.swift
//  music-lovers
//
//  Created by Christopher Reitz on 08/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

struct Identifier {
    let type: String
    let value: String
}

extension Identifier: JSONInitializable {
    init?(json: JSON) {
        guard
            let type = json["type"] as? String,
            let value = json["value"] as? String
        else {
            return nil
        }

        self.type = type
        self.value = value
    }
}
