//
//  Image.swift
//  music-lovers
//
//  Created by Christopher Reitz on 08/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import Foundation

struct Image {
    let type: String
    let width: Int
    let height: Int
    let resourceUrl: URL
    let uri: URL
    let uri150: URL
}

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
        }

        self.type = type
        self.width = width
        self.height = height
        self.resourceUrl = resourceUrl
        self.uri = uri
        self.uri150 = uri150
    }
}
