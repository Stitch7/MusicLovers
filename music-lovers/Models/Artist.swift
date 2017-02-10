***REMOVED***
***REMOVED***  Artist.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 08/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import Foundation

struct Artist {
    let id: Int
    let name: String
    let resourceUrl: URL

    let role: String?
    let images: [Image]?
    let profile: String?
    let aliases: [Alias]?
    let members: [Member]?
    let namevariations: [String]?
    let urls: [URL]?
***REMOVED***

extension Artist {
    var mainImage: Image? {
        return images?.first
***REMOVED***
***REMOVED***

extension Artist: JSONInitializable {
    init?(json: JSON) {
        guard
            let id = json["id"] as? Int,
            let name = json["name"] as? String,
            let resourceUrlStr = json["resource_url"] as? String,
            let resourceUrl = URL(string: resourceUrlStr)
        else {
            return nil
    ***REMOVED***

        let imagesJson = json["images"] as? [JSON] ?? [JSON]()
        let aliasesJson = json["aliases"] as? [JSON] ?? [JSON]()
        let membersJson = json["members"] as? [JSON] ?? [JSON]()

        ***REMOVED*** Combine `uri` + `urls`
        let urlsStr = json["urls"] as? [String]
        var urls = urlsStr?.flatMap{URL(string: $0)***REMOVED***
        if let uriStr = json["uri"] as? String, let uri = URL(string: uriStr) {
            urls?.append(uri)
    ***REMOVED***

        self.id = id
        self.name = name
        self.resourceUrl = resourceUrl
        self.role = json["role"] as? String
        self.images = imagesJson.flatMap(Image.init)
        self.profile = json["profile"] as? String
        self.aliases = aliasesJson.flatMap(Alias.init)
        self.members = membersJson.flatMap(Member.init)
        self.namevariations = json["namevariations"] as? [String]
        self.urls = urls
***REMOVED***
***REMOVED***
