***REMOVED***
***REMOVED***  Release.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 08/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import Foundation

struct Release {
    let id: Int
    let artists: [Artist]
    let companies: [Company]
    let country: String
    let dataQuality: String
    let dateAdded: Date
    let dateChanged: Date
    let extraArtists: [Artist]
    let formatQuantity: Int
    let formats: [Format]
    let genres: [String]
    let identifiers: [Identifier]
    let images: [Image]
    let labels: [Label]
***REMOVED***    let lowestPrice: Double
***REMOVED***    let masterId: Int
***REMOVED***    let masterUrl: URL
    let notes: String
    let numForSale: Int
***REMOVED***    let released: Date
***REMOVED***    let released: String
    let resourceUrl: URL
    let status: String
    let title: String
    let tracklist: [Track]
    let uri: URL
    let videos: [Video]
    let year: Int
***REMOVED***

extension Release {
    var mainImage: Image? {
        return images.first
***REMOVED***
***REMOVED***

extension Release: JSONInitializable {
    init?(json: JSON) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

***REMOVED***        let releasedFormatter = DateFormatter()
***REMOVED***        releasedFormatter.dateFormat = "yyyy-MM-dd"

        guard
            let id = json["id"] as? Int,
            let artistsJson = json["artists"] as? [JSON],
            let companiesJson = json["companies"] as? [JSON],
            let country = json["country"] as? String,
            let dataQuality = json["data_quality"] as? String,
            let dateAddedStr = json["date_added"] as? String,
            let dateAdded = dateFormatter.date(from: dateAddedStr),
            let dateChangedStr = json["date_changed"] as? String,
            let dateChanged = dateFormatter.date(from: dateChangedStr),
            let extraArtistsJson = json["extraartists"] as? [JSON],
            let formatQuantity = json["format_quantity"] as? Int,
            let formatsJson = json["formats"] as? [JSON],
            let genres = json["genres"] as? [String],
            let identifiersJson = json["identifiers"] as? [JSON],
            let imagesJson = json["images"] as? [JSON],
            let labelsJson = json["labels"] as? [JSON],
***REMOVED***            let lowestPrice = json["lowest_price"] as? Double,
***REMOVED***            let masterId = json["master_id"] as? Int,
***REMOVED***            let masterUrlStr = json["master_url"] as? String,
***REMOVED***            let masterUrl = URL(string: masterUrlStr),
            let numForSale = json["num_for_sale"] as? Int,
***REMOVED***            let released = json["released"] as? String,
***REMOVED***            let released = releasedFormatter.date(from: releasedStr),
            let resourceUrlStr = json["resource_url"] as? String,
            let resourceUrl = URL(string: resourceUrlStr),
            let status = json["status"] as? String,
            let title = json["title"] as? String,
            let tracklistJson = json["tracklist"] as? [JSON],
            let uriStr = json["uri"] as? String,
            let uri = URL(string: uriStr),
            let year = json["year"] as? Int
        else {
            return nil
    ***REMOVED***

        let notes = json["notes"] as? String ?? ""
        let videosJson = json["videos"] as? [JSON] ?? [JSON]()

        self.id = id
        self.artists = artistsJson.flatMap(Artist.init)
        self.companies = companiesJson.flatMap(Company.init)
        self.country = country
        self.dataQuality = dataQuality
        self.dateAdded = dateAdded
        self.dateChanged = dateChanged
        self.extraArtists = extraArtistsJson.flatMap(Artist.init)
        self.formatQuantity = formatQuantity
        self.formats = formatsJson.flatMap(Format.init)
        self.genres = genres
        self.identifiers = identifiersJson.flatMap(Identifier.init)
        self.images = imagesJson.flatMap(Image.init)
        self.labels = labelsJson.flatMap(Label.init)
***REMOVED***        self.lowestPrice = lowestPrice
***REMOVED***        self.masterId = masterId
***REMOVED***        self.masterUrl = masterUrl
        self.notes = notes
        self.numForSale = numForSale
***REMOVED***        self.released = released
        self.resourceUrl = resourceUrl
        self.status = status
        self.title = title
        self.tracklist = tracklistJson.flatMap(Track.init)
        self.uri = uri
        self.videos = videosJson.flatMap(Video.init)
        self.year = year
***REMOVED***
***REMOVED***
