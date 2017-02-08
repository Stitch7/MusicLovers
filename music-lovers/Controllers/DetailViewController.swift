***REMOVED***
***REMOVED***  DetailViewController.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 08/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import UIKit

class DetailViewController: UITableViewController {

    var searchItem: SearchItem? {
        didSet {
            self.configureView()
    ***REMOVED***
***REMOVED***

    var release: Release?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
***REMOVED***

    func configureView() {
        guard let searchItem = self.searchItem else { return ***REMOVED***

        title = searchItem.title

        guard let url = URL(string: Config.DiscogsApi.BaseUrl) else {
            fatalError("Invalid DiscogsApi.BaseUrl in Config")
    ***REMOVED***

        let credentials = Credentials(key: Config.DiscogsApi.Key, secret: Config.DiscogsApi.Secret)
        let foundationClient = FoundationClient(url: url, credentials: credentials)
        let discogsClient = DiscogsClient(httpClient: foundationClient)

        discogsClient.release(id: searchItem.id) { result in
            switch result {
            case .success(let release):
                ***REMOVED*** TODO: why optional?
                guard let release = release else { return ***REMOVED***

                DispatchQueue.main.async {
                    self.release = release
                    self.tableView.reloadData()

                    if let imageUrl = release.mainImage?.uri {
                        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                            guard
                                error == nil,
                                let data = data,
                                let image = UIImage(data: data)
                            else {
                                print("error on download \(error!)")
                                return
                        ***REMOVED***

                            DispatchQueue.main.async {
                                let headerImageView = UIImageView()
                                headerImageView.contentMode = .scaleAspectFit
                                headerImageView.image = image
                                self.tableView.tableHeaderView = headerImageView

                                ***REMOVED*** Calculate header's frame and set it again
                                let height = headerImageView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
                                var headerFrame = headerImageView.frame
                                headerFrame.size.height = height
                                headerImageView.frame = headerFrame
                                self.tableView.tableHeaderView = headerImageView
                        ***REMOVED***
                    ***REMOVED***.resume()
                ***REMOVED***
            ***REMOVED***
            case .failure(let error):
                if case let .requestFailed(statusCode, message) = error as! HttpError {
                    print("discogsClient.failure: statusCode: \(statusCode) - message: \(message)")
            ***REMOVED***
        ***REMOVED***
    ***REMOVED***
***REMOVED***

    ***REMOVED*** MARK: - Table View

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Tracks"
***REMOVED***

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return release?.tracklist.count ?? 0
***REMOVED***

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let track = release?.tracklist[indexPath.row]

        cell.textLabel?.text = track?.title
        
        return cell
***REMOVED***
***REMOVED***
