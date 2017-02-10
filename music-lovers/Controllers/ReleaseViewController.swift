***REMOVED***
***REMOVED***  ReleaseViewController.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 08/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import UIKit

class ReleaseViewController: UITableViewController {

    ***REMOVED*** MARK: - Properties

    var searchItem: SearchItem? {
        didSet {
            self.configureView()
    ***REMOVED***
***REMOVED***
    var discogsClient: DiscogsClient?

    let loadingView = LoadingView()
    lazy var dataSource: SectionsDataSource<ReleaseSections> = {
        SectionsDataSource<ReleaseSections>(tableView: self.tableView)
***REMOVED***()

    ***REMOVED*** MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureTableView()
        loadData()
***REMOVED***

    func configureView() {
        navigationController?.view.addSubview(loadingView)

        let views =  ["loadingView": loadingView]
        navigationController?.view.addConstraints(format: "V:|[loadingView]|", views: views)
        navigationController?.view.addConstraints(format: "H:|[loadingView]|", views: views)
***REMOVED***

    func loadData() {
        guard let searchItem = self.searchItem else { return ***REMOVED***

        loadingView.isHidden = false

        discogsClient?.release(id: searchItem.id) { result in
            switch result {
            case .success(let release):
                ***REMOVED*** TODO: show error
                guard let release = release else {
                    self.loadingView.remove()
                    return
            ***REMOVED***

                self.dataSource.object = release
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.title = release.title

                    self.loadingView.remove()
            ***REMOVED***
            case .failure(let error):
                self.loadingView.remove()
                if case let .requestFailed(statusCode, message) = error as! HttpError {
                    print("discogsClient.failure: statusCode: \(statusCode) - message: \(message)")
            ***REMOVED***
        ***REMOVED***
    ***REMOVED***
***REMOVED***

    func configureTableView() {
        tableView.dataSource = dataSource
***REMOVED***

    ***REMOVED*** MARK: - UITableViewDelegate

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
                let artist = (dataSource.object as? Release)?.artists[indexPath.row]
                let artistVC = segue.destination as! ArtistViewController
                artistVC.baseArtist = artist
                artistVC.discogsClient = discogsClient
        ***REMOVED***
    ***REMOVED***
***REMOVED***
***REMOVED***
