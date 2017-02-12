//
//  ReleaseViewController.swift
//  music-lovers
//
//  Created by Christopher Reitz on 08/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import UIKit

class ReleaseViewController: UITableViewController {

    // MARK: - Properties

    lazy var dataSource: SectionsDataSource<ReleaseSections> = {
        SectionsDataSource<ReleaseSections>(tableView: self.tableView)
    }()

    var searchItem: SearchItem?
    var delegate: SectionsDataDelegate<ReleaseSections>?
    var discogsClient: DiscogsClient?
    let loadingView = LoadingView()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = SectionsDataDelegate<ReleaseSections>(tableView: self.tableView) { indexPath in
            self.didSelectRowAt(indexPath: indexPath)
        }

        configure(loadingView: loadingView)
        loadData()
    }

    func loadData() {
        guard let searchItem = self.searchItem else { return }

        loadingView.isHidden = false

        discogsClient?.release(id: searchItem.id) { result in
            switch result {
            case .success(let release):
                // TODO: show error
                guard let release = release else {
                    self.loadingView.remove()
                    DispatchQueue.main.async {
                        _ = self.navigationController?.popViewController(animated: true)
                    }
                    return
                }

                self.dataSource.object = release
                self.delegate?.object = release
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.title = release.title

                    if let imageUrl = release.mainImage?.uri {
                        UIImage.downloadFrom(url: imageUrl) { image in
                            guard let coverImage = image else { return }
                            self.tableView.setBlurredBackground(image: coverImage)
                            self.loadingView.remove()
                        }
                    }
                    else {
                        self.loadingView.remove()
                    }
                }
            case .failure(let error):
                self.loadingView.remove()
                if case let .requestFailed(statusCode, message) = error as! HttpError {
                    print("discogsClient.failure: statusCode: \(statusCode) - message: \(message)")
                }
            }
        }
    }

    // MARK: - Events

    func didSelectRowAt(indexPath: IndexPath) {
        guard let releaseSection = ReleaseSections(rawValue: indexPath.section) else { fatalError("Invalid section") }

        switch releaseSection {
        case .artist:
            performSegue(withIdentifier: "showArtist", sender: indexPath)
        case .videos:
            let selectedCell = tableView.cellForRow(at: indexPath) as? VideoTableViewCell
            if let videoUrl = selectedCell?.video?.uri {
                UIApplication.shared.open(videoUrl)
            }
        default: return
        }
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showArtist" {
            if let indexPath = sender as? IndexPath {
                let artist = (dataSource.object as? Release)?.artists[indexPath.row]
                let artistVC = segue.destination as! ArtistViewController
                artistVC.baseArtist = artist
                artistVC.discogsClient = discogsClient
            }
        }
    }
}
