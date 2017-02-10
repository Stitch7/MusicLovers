***REMOVED***
***REMOVED***  ArtistTableViewController.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 09/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import UIKit

enum ArtistSections: Int {
    case profile
    case discography
    case members
    case aliases
    case namevariations
    case urls

    var name: String {
        switch self {
        case .profile: return "Profile"
        case .discography: return "Discography"
        case .members: return "Members"
        case .aliases: return "Aliases"
        case .namevariations: return "Name Variations"
        case .urls: return "Links"
    ***REMOVED***
***REMOVED***
***REMOVED***

class ArtistTableViewController: UITableViewController {

    var discogsClient: DiscogsClient = {
        guard let url = URL(string: Config.DiscogsApi.BaseUrl) else {
            fatalError("Invalid DiscogsApi.BaseUrl in Config")
    ***REMOVED***

        let credentials = Credentials(key: Config.DiscogsApi.Key, secret: Config.DiscogsApi.Secret)
        let foundationClient = FoundationClient(url: url, credentials: credentials)
        return DiscogsClient(httpClient: foundationClient)
***REMOVED***()

    var artist: Artist? {
        didSet {
            title = artist?.name
    ***REMOVED***
***REMOVED***

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()

        guard let artist = self.artist else { return ***REMOVED***

        let loadingView = LoadingView()
        loadingView.isHidden = false
        navigationController?.view.addSubview(loadingView)

        let views =  ["loadingView": loadingView]
        navigationController?.view.addConstraints(format: "V:|[loadingView]|", views: views)
        navigationController?.view.addConstraints(format: "H:|[loadingView]|", views: views)

        discogsClient.artist(id: artist.id) { result in
            switch result {
            case .success(let artist):
                ***REMOVED*** TODO: show error
                guard let artist = artist else {
                    loadingView.remove()
                    return
            ***REMOVED***

                DispatchQueue.main.async {
                    self.artist = artist
                    self.tableView.reloadData()
                    if let image = artist.mainImage {
                        UIImage.downloadFrom(url: image.uri, completion: { image in
                            defer {
                                loadingView.remove()
                        ***REMOVED***
                            guard let artistImage = image else { return ***REMOVED***
                            let artistImageView = UIImageView(image: artistImage)
***REMOVED***                            artistImageView.contentMode = .scaleAspectFit
                            self.tableView.setAndLayoutTableHeaderView(header: artistImageView)
                    ***REMOVED***)
                ***REMOVED***
            ***REMOVED***
            case .failure(let error):
                loadingView.removeFromSuperview()
                if case let .requestFailed(statusCode, message) = error as! HttpError {
                    print("discogsClient.failure: statusCode: \(statusCode) - message: \(message)")
            ***REMOVED***
        ***REMOVED***
    ***REMOVED***
***REMOVED***

    func configureTableView() {
        tableView.register(UINib(nibName: "ArtistTableViewCell", bundle: nil), forCellReuseIdentifier: "ArtistCell")
        tableView.register(UINib(nibName: "VideoTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoCell")

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 21
***REMOVED***

    ***REMOVED*** MARK: - Table View

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ArtistSections(rawValue: section)?.name
***REMOVED***

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 6
***REMOVED***

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let artistSection = ArtistSections(rawValue: section) else { return 0 ***REMOVED***

        switch artistSection {
        case .profile:
            return 1
        case .discography:
            return 1
        case .members:
            return artist?.members?.count ?? 0
        case .aliases:
            return artist?.aliases?.count ?? 0
        case .namevariations:
            return artist?.namevariations?.count ?? 0
        case .urls:
            return artist?.urls?.count ?? 0
    ***REMOVED***
***REMOVED***

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let artistSection = ArtistSections(rawValue: indexPath.section) else { fatalError("Invalid section") ***REMOVED***

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.selectionStyle = .none
        cell.accessoryType = .none

        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15.0)
        cell.textLabel?.textColor = .black
        cell.textLabel?.text = nil
        cell.textLabel?.attributedText = nil

        switch artistSection {
        case .profile:
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14.0)
            cell.textLabel?.text = artist?.profile
        case .discography:
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.textColor = view.tintColor
            cell.textLabel?.text = "Discography"
        case .members:
            if let member = artist?.members?[indexPath.row] {
                if member.active {
                    cell.textLabel?.text = member.name
            ***REMOVED*** else {
                    let inactiveName = NSMutableAttributedString(string: member.name)
                    inactiveName.addAttribute(NSStrikethroughStyleAttributeName,
                                              value: 1,
                                              range: NSMakeRange(0, inactiveName.length))
                    cell.textLabel?.attributedText = inactiveName
            ***REMOVED***
        ***REMOVED***
        case .aliases:
            if let alias = artist?.aliases?[indexPath.row] {
                cell.textLabel?.text = alias.name
        ***REMOVED***
        case .namevariations:
            if let namevariation = artist?.namevariations?[indexPath.row] {
                cell.textLabel?.text = namevariation
        ***REMOVED***
        case .urls:
            if let url = artist?.urls?[indexPath.row] {
                cell.textLabel?.text = url.absoluteString
        ***REMOVED***
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.textColor = view.tintColor
    ***REMOVED***

        return cell
***REMOVED***

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let artistSection = ArtistSections(rawValue: indexPath.section) else { fatalError("Invalid section") ***REMOVED***

        switch artistSection {
        case .discography:
            performSegue(withIdentifier: "showDiscography", sender: indexPath)
        case .urls:
            if let url = artist?.urls?[indexPath.row] {
                UIApplication.shared.open(url)
        ***REMOVED***
        default: return
    ***REMOVED***
***REMOVED***

    ***REMOVED*** MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDiscography" {
            let discographyVC = segue.destination as! DiscographyTableViewController
            discographyVC.artist = artist
    ***REMOVED***
***REMOVED***
***REMOVED***
