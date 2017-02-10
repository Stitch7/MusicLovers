***REMOVED***
***REMOVED***  DiscographyTableViewController.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 10/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import UIKit

class DiscographyTableViewController: UITableViewController {

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

    var records = [Record]()
    var cache = NSCache<NSString, UIImage>()

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

        discogsClient.discography(artistId: artist.id) { result in
            switch result {
            case .success(let records):
                ***REMOVED*** TODO: show error
                guard let records = records else {
                    loadingView.remove()
                    return
            ***REMOVED***

                DispatchQueue.main.async {
                    self.records = records
                    self.tableView.reloadData()

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
        tableView.register(UINib(nibName: "RecordTableViewCell", bundle: nil), forCellReuseIdentifier: "RecordCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
***REMOVED***

    ***REMOVED*** MARK: - Table View

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Discography"
***REMOVED***

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
***REMOVED***

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath) as! RecordTableViewCell

        let record = records[indexPath.row]
        cell.record = record

        let cacheKey = NSString(string: record.thumb.absoluteString)
        if let cachedImage = cache.object(forKey: cacheKey) {
            cell.coverImageView?.image = cachedImage
    ***REMOVED*** else {
            cell.coverImageView?.image = UIImage(named: "default-release")
            downloadFrom(url: record.thumb) { data in
                guard
                    let imageData = data,
                    let image = UIImage(data: imageData)
                    else { return ***REMOVED***

                self.cache.setObject(image, forKey: cacheKey)

                if let updateCell = tableView.cellForRow(at: indexPath) as? RecordTableViewCell {
                    updateCell.coverImageView?.image = image
            ***REMOVED***
        ***REMOVED***
    ***REMOVED***

        return cell
***REMOVED***

    func downloadFrom(url: URL, completion completionHandler: @escaping (Data?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("error on download \(error!)")
                return
        ***REMOVED***
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("statusCode != 200")
                return
        ***REMOVED***
            
            DispatchQueue.main.async {
                completionHandler(data)
        ***REMOVED***
    ***REMOVED***.resume()
***REMOVED***
***REMOVED***
