***REMOVED***
***REMOVED***  DiscographyTableViewController.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 10/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import UIKit

class DiscographyViewController: UITableViewController {

    ***REMOVED*** MARK: - Properties

    var artist: Artist? {
        didSet {
            title = artist?.name
    ***REMOVED***
***REMOVED***
    var discogsClient: DiscogsClient?
    var records = [Record]()
    var cache = NSCache<NSString, UIImage>()

    ***REMOVED*** MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()

        guard let artist = self.artist, let discogsClient = self.discogsClient else { return ***REMOVED***

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
            UIImage.downloadFrom(url: record.thumb) { image in
                guard let image = image else { return ***REMOVED***

                self.cache.setObject(image, forKey: cacheKey)
                if let updateCell = tableView.cellForRow(at: indexPath) as? RecordTableViewCell {
                    updateCell.coverImageView?.image = image
            ***REMOVED***
        ***REMOVED***
    ***REMOVED***

        return cell
***REMOVED***
***REMOVED***
