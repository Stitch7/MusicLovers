***REMOVED***
***REMOVED***  ArtistTableViewController.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 09/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import UIKit

class ArtistViewController: UITableViewController {

    ***REMOVED*** MARK: - Properties

    var baseArtist: Artist? {
        didSet {
            title = baseArtist?.name
    ***REMOVED***
***REMOVED***
    var discogsClient: DiscogsClient?

    lazy var dataSource: SectionsDataSource<ArtistSections> = {
        SectionsDataSource<ArtistSections>(tableView: self.tableView)
***REMOVED***()

    let loadingView = LoadingView()

    ***REMOVED*** MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        configureLoadingView()
        loadData()
***REMOVED***

    func configureTableView() {
        tableView.dataSource = dataSource
***REMOVED***

    func configureLoadingView() {
        navigationController?.view.addSubview(loadingView)

        let views =  ["loadingView": loadingView]
        navigationController?.view.addConstraints(format: "V:|[loadingView]|", views: views)
        navigationController?.view.addConstraints(format: "H:|[loadingView]|", views: views)
***REMOVED***

    func loadData() {
        guard let baseArtist = self.baseArtist else { return ***REMOVED***

        loadingView.isHidden = false

        discogsClient?.artist(id: baseArtist.id) { result in
            switch result {
            case .success(let artist):
                ***REMOVED*** TODO: show error
                guard let artist = artist else {
                    self.loadingView.remove()
                    return
            ***REMOVED***

                self.dataSource.object = artist
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    if let image = artist.mainImage {
                        UIImage.downloadFrom(url: image.uri, completion: { image in
                            defer {
                                self.loadingView.remove()
                        ***REMOVED***
                            guard let artistImage = image else { return ***REMOVED***
                            let artistImageView = UIImageView(image: artistImage)
                            self.tableView.setAndLayoutTableHeaderView(header: artistImageView)
                    ***REMOVED***)
                ***REMOVED***
            ***REMOVED***
            case .failure(let error):
                self.loadingView.remove()
                if case let .requestFailed(statusCode, message) = error as! HttpError {
                    print("discogsClient.failure: statusCode: \(statusCode) - message: \(message)")
            ***REMOVED***
        ***REMOVED***
    ***REMOVED***
***REMOVED***

    ***REMOVED*** MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let artistSection = ArtistSections(rawValue: indexPath.section) else { fatalError("Invalid section") ***REMOVED***

        switch artistSection {
        case .discography:
            performSegue(withIdentifier: "showDiscography", sender: indexPath)
        case .urls:
            if let url = (dataSource.object as? Artist)?.urls?[indexPath.row] {
                UIApplication.shared.open(url)
        ***REMOVED***
        default: return
    ***REMOVED***
***REMOVED***

    ***REMOVED*** MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDiscography" {
            let discographyVC = segue.destination as! DiscographyViewController
            discographyVC.artist = dataSource.object as? Artist
            discographyVC.discogsClient = discogsClient
    ***REMOVED***
***REMOVED***
***REMOVED***
