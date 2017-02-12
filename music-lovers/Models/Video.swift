//
//  Video.swift
//  music-lovers
//
//  Created by Christopher Reitz on 08/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import Foundation

struct Video {
    let title: String
    let description: String
    let duration: Int
    let embed: Bool
    let uri: URL

    var durationString: String {
        let m = (duration % 3600) / 60
        let mFormatted = String(m).leftPadding(toLength: 2, withPad: "0")

        let s = (duration % 3600) % 60
        let sFormatted = String(s).leftPadding(toLength: 2, withPad: "0")

        return "\(mFormatted):\(sFormatted)"
    }
}

extension Video: JSONInitializable {
    init?(json: JSON) {
        guard
            let title = json["title"] as? String,
            let description = json["description"] as? String,
            let duration = json["duration"] as? Int,
            let embed = json["embed"] as? Bool,
            let uriStr = json["uri"] as? String,
            let uri = URL(string: uriStr)
        else {
            return nil
        }

        self.title = title
        self.description = description
        self.duration = duration
        self.embed = embed
        self.uri = uri
    }
}
