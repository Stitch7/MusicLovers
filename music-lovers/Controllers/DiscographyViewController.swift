//
//  DiscographyTableViewController.swift
//  music-lovers
//
//  Created by Christopher Reitz on 10/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import UIKit

class DiscographyViewController: UITableViewController {

    // MARK: - Properties

    var artist: Artist? {
        didSet {
            title = artist?.name
        }
    }
    var discogsClient: DiscogsClient?
    var records = [Record]()
    var cache = NSCache<NSString, UIImage>()
    let loadingView = LoadingView()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        configure(loadingView: loadingView)
        loadData()
    }

    func loadData() {
        guard let artist = self.artist, let discogsClient = self.discogsClient else { return }

        loadingView.isHidden = false

        discogsClient.discography(artistId: artist.id) { result in
            switch result {
            case .success(let records):
                // TODO: show error
                guard let records = records else {
                    self.loadingView.remove()
                    _ = self.navigationController?.popViewController(animated: true)
                    return
                }

                DispatchQueue.main.async {
                    self.records = records
                    self.tableView.reloadData()

                    self.loadingView.remove()
                }
            case .failure(let error):
                self.loadingView.remove()
                if case let .requestFailed(statusCode, message) = error as! HttpError {
                    print("discogsClient.failure: statusCode: \(statusCode) - message: \(message)")
                }
            }
        }
    }

    func configureTableView() {
        tableView.register(UINib(nibName: "RecordTableViewCell", bundle: nil), forCellReuseIdentifier: "RecordCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }

    // MARK: - Table View

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Discography"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath) as! RecordTableViewCell

        let record = records[indexPath.row]
        cell.record = record

        let cacheKey = NSString(string: record.thumb.absoluteString)
        if let cachedImage = cache.object(forKey: cacheKey) {
            cell.coverImageView?.image = cachedImage
        } else {
            cell.coverImageView?.image = UIImage(named: "default-release")
            UIImage.downloadFrom(url: record.thumb) { image in
                guard let image = image else { return }

                self.cache.setObject(image, forKey: cacheKey)
                if let updateCell = tableView.cellForRow(at: indexPath) as? RecordTableViewCell {
                    updateCell.coverImageView?.image = image
                }
            }
        }

        return cell
    }
}
