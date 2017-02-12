//
//  ReleaseSections.swift
//  music-lovers
//
//  Created by Christopher Reitz on 10/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import UIKit

enum ReleaseSections: Int {
    case teaser
    case artist
    case tracks
    case notes
    case credits
    case videos
}

extension ReleaseSections: SectionsDataEnum {

    static let numbersOfSections = 6

    static func setup(tableView: UITableView) {
        tableView.register(UINib(nibName: "ReleaseTableViewCell", bundle: nil), forCellReuseIdentifier: "ReleaseCell")
        tableView.register(UINib(nibName: "TrackTableViewCell", bundle: nil), forCellReuseIdentifier: "TrackCell")
        tableView.register(UINib(nibName: "VideoTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoCell")
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.estimatedRowHeight = 21
    }

    var name: String? {
        switch self {
        case .teaser: return nil
        case .artist: return "Artist".localized
        case .tracks: return "Tracks".localized
        case .notes: return "Notes".localized
        case .credits: return "Credits".localized
        case .videos: return "Videos".localized
        }
    }

    func numberOfRows(object: Any) -> Int {
        guard let release = object as? Release else { return 0 }

        switch self {
        case .teaser: return 1
        case .artist: return release.artists.count
        case .tracks: return release.tracklist.count
        case .notes: return release.notes.characters.count > 0 ? 1 : 0
        case .credits: return release.extraArtists.count
        case .videos: return release.videos.count
        }
    }

    func generateCell(for tableView: UITableView, at indexPath: IndexPath, with object: Any?) -> UITableViewCell {
        let release = object as? Release
        switch self {
        case .teaser: return generateTeaserCell(for: tableView, at: indexPath, with: release)
        case .artist: return generateArtistCell(for: tableView, at: indexPath, with: release)
        case .tracks: return generateTracksCell(for: tableView, at: indexPath, with: release)
        case .notes: return generateNotesCell(for: tableView, at: indexPath, with: release)
        case .credits: return generateCreditsCell(for: tableView, at: indexPath, with: release)
        case .videos: return generateVideosCell(for: tableView, at: indexPath, with: release)
        }
    }

    func generateTeaserCell(for tableView: UITableView, at indexPath: IndexPath, with release: Release?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReleaseCell", for: indexPath) as! ReleaseTableViewCell
        cell.release = release
        return cell
    }

    func generateArtistCell(for tableView: UITableView, at indexPath: IndexPath, with release: Release?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15.0)
        cell.textLabel?.textColor = UIApplication.tintColor
        let artist = release?.artists[indexPath.row]
        cell.textLabel?.text = [artist?.role, artist?.name].flatMap{$0}.filter{!$0.isEmpty}.joined(separator: " - ")
        return cell
    }

    func generateTracksCell(for tableView: UITableView, at indexPath: IndexPath, with release: Release?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as! TrackTableViewCell
        cell.track = release?.tracklist[indexPath.row]
        return cell
    }

    func generateNotesCell(for tableView: UITableView, at indexPath: IndexPath, with release: Release?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.accessoryType = .none
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14.0)
        cell.textLabel?.textColor = .black
        cell.textLabel?.text = release?.notes
        return cell
    }

    func generateCreditsCell(for tableView: UITableView, at indexPath: IndexPath, with release: Release?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.accessoryType = .none
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15.0)
        cell.textLabel?.textColor = .black
        let artist = release?.extraArtists[indexPath.row]
        cell.textLabel?.text = [artist?.role, artist?.name].flatMap{$0}.filter{!$0.isEmpty}.joined(separator: " - ")
        return cell
    }

    func generateVideosCell(for tableView: UITableView, at indexPath: IndexPath, with release: Release?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoTableViewCell
        cell.video = release?.videos[indexPath.row]
        return cell
    }
}
