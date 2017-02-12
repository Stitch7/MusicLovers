//
//  ArtistTableViewController.swift
//  music-lovers
//
//  Created by Christopher Reitz on 09/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import UIKit

class ArtistViewController: UITableViewController {

    // MARK: - Properties

    var baseArtist: Artist? {
        didSet {
            title = baseArtist?.name
        }
    }
    var discogsClient: DiscogsClient?

    let loadingView = LoadingView()
    lazy var dataSource: SectionsDataSource<ArtistSections> = {
        SectionsDataSource<ArtistSections>(tableView: self.tableView)
    }()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        configure(loadingView: loadingView)
        loadData()
    }

    func loadData() {
        guard let baseArtist = self.baseArtist else { return }

        loadingView.isHidden = false

        discogsClient?.artist(id: baseArtist.id) { result in
            switch result {
            case .success(let artist):
                // TODO: show error
                guard let artist = artist else {
                    self.loadingView.remove()
                    _ = self.navigationController?.popViewController(animated: true)
                    return
                }

                self.dataSource.object = artist
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    if let image = artist.mainImage {
                        UIImage.downloadFrom(url: image.uri, completion: { image in
                            defer {
                                self.loadingView.remove()
                            }
                            guard let artistImage = image else { return }
                            let artistImageView = UIImageView(image: artistImage)
                            self.tableView.setAndLayoutTableHeaderView(header: artistImageView)
                        })
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

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let artistSection = ArtistSections(rawValue: indexPath.section) else { fatalError("Invalid section") }

        switch artistSection {
        case .discography:
            performSegue(withIdentifier: "showDiscography", sender: indexPath)
        case .urls:
            if let url = (dataSource.object as? Artist)?.urls?[indexPath.row] {
                UIApplication.shared.open(url)
            }
        default: return
        }
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDiscography" {
            let discographyVC = segue.destination as! DiscographyViewController
            discographyVC.artist = dataSource.object as? Artist
            discographyVC.discogsClient = discogsClient
        }
    }
}
