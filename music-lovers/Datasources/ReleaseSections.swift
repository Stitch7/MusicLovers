***REMOVED***
***REMOVED***  ReleaseSections.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 10/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import UIKit

enum ReleaseSections: Int {
    case teaser
    case artist
    case tracks
    case notes
    case credits
    case videos
***REMOVED***

extension ReleaseSections: SectionsDataEnum {

    static let numbersOfSections = 6

    static func setup(tableView: UITableView) {
        tableView.register(UINib(nibName: "ReleaseTableViewCell", bundle: nil), forCellReuseIdentifier: "ReleaseCell")
        tableView.register(UINib(nibName: "TrackTableViewCell", bundle: nil), forCellReuseIdentifier: "TrackCell")
        tableView.register(UINib(nibName: "VideoTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoCell")
        tableView.estimatedRowHeight = 21
***REMOVED***

    var name: String? {
        switch self {
        case .teaser: return nil
        case .artist: return "Artist"
        case .tracks: return "Tracks"
        case .notes: return "Notes"
        case .credits: return "Credits"
        case .videos: return "Videos"
    ***REMOVED***
***REMOVED***

    func numberOfRows(object: Any) -> Int {
        guard let release = object as? Release else { return 0 ***REMOVED***

        switch self {
        case .teaser: return 1
        case .artist: return release.artists.count
        case .tracks: return release.tracklist.count
        case .notes: return release.notes.characters.count > 0 ? 1 : 0
        case .credits: return release.extraArtists.count
        case .videos: return release.videos.count
    ***REMOVED***
***REMOVED***

    func generateCell(for tableView: UITableView, at indexPath: IndexPath, with object: Any?) -> UITableViewCell {
        let release = object as? Release
        switch self {
        case .teaser: return generateTeaserCell(for: tableView, at: indexPath, with: release)
        case .artist: return generateArtistCell(for: tableView, at: indexPath, with: release)
        case .tracks: return generateTracksCell(for: tableView, at: indexPath, with: release)
        case .notes: return generateNotesCell(for: tableView, at: indexPath, with: release)
        case .credits: return generateCreditsCell(for: tableView, at: indexPath, with: release)
        case .videos: return generateVideosCell(for: tableView, at: indexPath, with: release)
    ***REMOVED***
***REMOVED***

    func generateTeaserCell(for tableView: UITableView, at indexPath: IndexPath, with release: Release?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReleaseCell", for: indexPath) as! ReleaseTableViewCell
        cell.release = release
        return cell
***REMOVED***

    func generateArtistCell(for tableView: UITableView, at indexPath: IndexPath, with release: Release?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.selectionStyle = .default
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15.0)
        ***REMOVED*** TODO
***REMOVED***        cell.textLabel?.textColor = UIApplication.shared.keyWindow?.tintColor
        cell.textLabel?.textColor = .blue
        let artist = release?.artists[indexPath.row]
        cell.textLabel?.text = [artist?.role, artist?.name].flatMap{$0***REMOVED***.filter{!$0.isEmpty***REMOVED***.joined(separator: " - ")
        return cell
***REMOVED***

    func generateTracksCell(for tableView: UITableView, at indexPath: IndexPath, with release: Release?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as! TrackTableViewCell
        cell.track = release?.tracklist[indexPath.row]
        return cell
***REMOVED***

    func generateNotesCell(for tableView: UITableView, at indexPath: IndexPath, with release: Release?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.selectionStyle = .none
        cell.accessoryType = .none
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14.0)
        cell.textLabel?.textColor = .black
        cell.textLabel?.text = release?.notes
        return cell
***REMOVED***

    func generateCreditsCell(for tableView: UITableView, at indexPath: IndexPath, with release: Release?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.selectionStyle = .none
        cell.accessoryType = .none
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15.0)
        cell.textLabel?.textColor = .black
        let artist = release?.extraArtists[indexPath.row]
        cell.textLabel?.text = [artist?.role, artist?.name].flatMap{$0***REMOVED***.filter{!$0.isEmpty***REMOVED***.joined(separator: " - ")
        return cell
***REMOVED***

    func generateVideosCell(for tableView: UITableView, at indexPath: IndexPath, with release: Release?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoTableViewCell
        cell.video = release?.videos[indexPath.row]
        return cell
***REMOVED***
***REMOVED***
