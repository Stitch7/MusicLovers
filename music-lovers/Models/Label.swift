//
//  Label.swift
//  music-lovers
//
//  Created by Christopher Reitz on 08/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import Foundation

struct Label {
    let id: Int
    let name: String
    let resourceUrl: URL
    let catNo: String
    let entityType: String
    let entityTypeName: String
}

extension Label: JSONInitializable {
    init?(json: JSON) {
        guard
            let id = json["id"] as? Int,
            let name = json["name"] as? String,
            let resourceUrlStr = json["resource_url"] as? String,
            let resourceUrl = URL(string: resourceUrlStr),
            let catNo = json["catno"] as? String,
            let entityType = json["entity_type"] as? String,
            let entityTypeName = json["entity_type_name"] as? String
        else {
            return nil
        }

        self.id = id
        self.name = name
        self.resourceUrl = resourceUrl
        self.catNo = catNo
        self.entityType = entityType
        self.entityTypeName = entityTypeName
    }
}
