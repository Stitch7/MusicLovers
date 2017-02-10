***REMOVED***
***REMOVED***  ReleaseViewController.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 08/02/2017.
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

class ReleaseViewController: UITableViewController {

    var searchItem: SearchItem? {
        didSet {
            self.configureView()
    ***REMOVED***
***REMOVED***

    var release: Release?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureTableView()
***REMOVED***

    func configureView() {
        guard let searchItem = self.searchItem else { return ***REMOVED***

        guard let url = URL(string: Config.DiscogsApi.BaseUrl) else {
            fatalError("Invalid DiscogsApi.BaseUrl in Config")
    ***REMOVED***

        let credentials = Credentials(key: Config.DiscogsApi.Key, secret: Config.DiscogsApi.Secret)
        let foundationClient = FoundationClient(url: url, credentials: credentials)
        let discogsClient = DiscogsClient(httpClient: foundationClient)

        let loadingView = LoadingView()
        loadingView.isHidden = false
        navigationController?.view.addSubview(loadingView)

        let views =  ["loadingView": loadingView]
        navigationController?.view.addConstraints(format: "V:|[loadingView]|", views: views)
        navigationController?.view.addConstraints(format: "H:|[loadingView]|", views: views)

        discogsClient.release(id: searchItem.id) { result in
            switch result {
            case .success(let release):
                ***REMOVED*** TODO: show error
                guard let release = release else {
                    loadingView.remove()
                    return
            ***REMOVED***

                DispatchQueue.main.async {
                    self.release = release
                    self.tableView.reloadData()
                    self.title = release.title

                    loadingView.remove()
            ***REMOVED***
            case .failure(let error):
                loadingView.remove()
                if case let .requestFailed(statusCode, message) = error as! HttpError {
                    print("discogsClient.failure: statusCode: \(statusCode) - message: \(message)")
            ***REMOVED***
        ***REMOVED***
    ***REMOVED***
***REMOVED***

    func configureTableView() {
        tableView.register(UINib(nibName: "ReleaseTableViewCell", bundle: nil), forCellReuseIdentifier: "ReleaseCell")
        tableView.register(UINib(nibName: "TrackTableViewCell", bundle: nil), forCellReuseIdentifier: "TrackCell")
        tableView.register(UINib(nibName: "VideoTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoCell")

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 21
***REMOVED***

    ***REMOVED*** MARK: - Table View

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let releaseSection = ReleaseSections(rawValue: section) else { return nil ***REMOVED***

        switch releaseSection {
        case .teaser: return nil
        case .artist: return "Artist"
        case .tracks: return "Tracks"
        case .notes: return "Notes"
        case .credits: return "Credits"
        case .videos: return "Videos"
    ***REMOVED***
***REMOVED***

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 6
***REMOVED***

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let releaseSection = ReleaseSections(rawValue: section) else { return 0 ***REMOVED***

        switch releaseSection {
        case .teaser: return 1
        case .artist: return release?.artists.count ?? 0
        case .tracks: return release?.tracklist.count ?? 0
        case .notes:
            guard let release = self.release else { return 0 ***REMOVED***
            return release.notes.characters.count > 0 ? 1 : 0
        case .credits: return release?.extraArtists.count ?? 0
        case .videos: return release?.videos.count ?? 0
    ***REMOVED***
***REMOVED***

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let releaseSection = ReleaseSections(rawValue: indexPath.section) else { fatalError("Invalid section") ***REMOVED***

        switch releaseSection {
        case .teaser:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReleaseCell", for: indexPath) as! ReleaseTableViewCell
            cell.release = release
            return cell
        case .artist:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.selectionStyle = .default
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15.0)
            cell.textLabel?.textColor = view.tintColor
            let artist = release?.artists[indexPath.row]
            cell.textLabel?.text = [artist?.role, artist?.name].flatMap{$0***REMOVED***.filter{!$0.isEmpty***REMOVED***.joined(separator: " - ")
            return cell
        case .tracks:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as! TrackTableViewCell
            cell.track = release?.tracklist[indexPath.row]
            return cell
        case .notes:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.selectionStyle = .none
            cell.accessoryType = .none
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14.0)
            cell.textLabel?.textColor = .black
            cell.textLabel?.text = release?.notes
            return cell
        case .credits:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.selectionStyle = .none
            cell.accessoryType = .none
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15.0)
            cell.textLabel?.textColor = .black
            let artist = release?.extraArtists[indexPath.row]
            cell.textLabel?.text = [artist?.role, artist?.name].flatMap{$0***REMOVED***.filter{!$0.isEmpty***REMOVED***.joined(separator: " - ")
            return cell
        case .videos:
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoTableViewCell
            cell.video = release?.videos[indexPath.row]
            return cell
    ***REMOVED***
***REMOVED***

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let releaseSection = ReleaseSections(rawValue: indexPath.section) else { fatalError("Invalid section") ***REMOVED***

        switch releaseSection {
        case .artist:
            performSegue(withIdentifier: "showArtist", sender: indexPath)
        case .videos:
            let selectedCell = tableView.cellForRow(at: indexPath) as? VideoTableViewCell
            if let videoUrl = selectedCell?.video?.uri {
                UIApplication.shared.open(videoUrl)
        ***REMOVED***
        default: return
    ***REMOVED***
***REMOVED***

    ***REMOVED*** MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showArtist" {
            if let indexPath = sender as? IndexPath {
                let artist = release?.artists[indexPath.row]
                let controller = segue.destination as! ArtistTableViewController
                controller.artist = artist
        ***REMOVED***
    ***REMOVED***
***REMOVED***
***REMOVED***
