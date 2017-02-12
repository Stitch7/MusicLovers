//
//  Alias.swift
//  music-lovers
//
//  Created by Christopher Reitz on 10/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import Foundation

struct Alias {
    let id: Int
    let name: String
    let resourceUrl: URL
}

extension Alias: JSONInitializable {
    init?(json: JSON) {
        guard
            let id = json["id"] as? Int,
            let name = json["name"] as? String,
            let resourceUrlStr = json["resource_url"] as? String,
            let resourceUrl = URL(string: resourceUrlStr)
        else {
            return nil
        }

        self.id = id
        self.name = name
        self.resourceUrl = resourceUrl
    }
}
