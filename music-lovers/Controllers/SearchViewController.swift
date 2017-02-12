//
//  SearchViewController.swift
//  music-lovers
//
//  Created by Christopher Reitz on 08/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController, UISearchBarDelegate {

    // MARK: - Properties

    var discogsClient: DiscogsClient = {
        guard let url = URL(string: Config.DiscogsApi.BaseUrl) else {
            fatalError("Invalid DiscogsApi.BaseUrl in Config")
        }

        let key = Config.DiscogsApi.Key
        let secret = Config.DiscogsApi.Secret

        if key.characters.count == 0 || secret.characters.count == 0 {
            fatalError("\n\nPlease add Discogs API credentials to Config.swift\n\n")
        }

        let credentials = Credentials(key: key, secret: secret)
        let foundationClient = FoundationClient(url: url, credentials: credentials)
        return DiscogsClient(httpClient: foundationClient)
    }()

    var detailViewController: ReleaseViewController? = nil
    let searchController = UISearchController(searchResultsController: nil)
    var searchItems = [SearchItem]()
    var cache = NSCache<NSString, UIImage>()

    let loadingView = LoadingView()
    let noResultsView = NoResultsView()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        configureDetailViewController()
        configureNavigationBar()
        configureTableView()
        configureLoadingView()
        configureNoResultsView()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        tableView.tableHeaderView = searchController.searchBar
    }

    func configureDetailViewController() {
        guard let split = self.splitViewController else { return }

        let controllers = split.viewControllers
        let navigationVC = controllers[controllers.count-1] as! UINavigationController
        self.detailViewController = navigationVC.topViewController as? ReleaseViewController
    }

    func configureNavigationBar() {
        title = "Music Lovers"
    }

    func configureTableView() {
        tableView.register(UINib(nibName: "SearchItemTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchItemCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100

        definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a record name"
    }

    func configureLoadingView() {
        searchController.view.addSubview(loadingView)

        let views =  ["loadingView": loadingView]
        searchController.view.addConstraints(format: "V:|[loadingView]|", views: views)
        searchController.view.addConstraints(format: "H:|[loadingView]|", views: views)
    }

    func configureNoResultsView() {
        searchController.view.addSubview(noResultsView)

        let views =  ["noResultsView": noResultsView]
        searchController.view.addConstraints(format: "V:|[noResultsView]|", views: views)
        searchController.view.addConstraints(format: "H:|[noResultsView]|", views: views)
    }

    // MARK: - Table View

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: indexPath)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchItemCell", for: indexPath) as! SearchItemTableViewCell

        let searchItem = searchItems[indexPath.row]
        cell.searchItem = searchItem

        let cacheKey = NSString(string: searchItem.thumb.absoluteString)
        if let cachedImage = cache.object(forKey: cacheKey) {
            cell.coverImageView?.image = cachedImage
        } else {
            cell.coverImageView?.image = UIImage(named: "default-release")
            UIImage.downloadFrom(url: searchItem.thumb) { image in
                guard let coverImage = image else { return }
                self.cache.setObject(coverImage, forKey: cacheKey)

                if let updateCell = tableView.cellForRow(at: indexPath) as? SearchItemTableViewCell {
                    updateCell.coverImageView?.image = coverImage
                }
            }
        }

        return cell
    }

    // MARK: - UISearchBarDelegate

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchString = searchController.searchBar.text else { return }

        noResultsView.isHidden = true
        loadingView.isHidden = false

        discogsClient.search(title: searchString) { result in
            switch result {
            case .success(let items):
                guard let searchItems = items, searchItems.count > 0 else {
                    DispatchQueue.main.async {
                        self.noResultsView.isHidden = false
                        self.loadingView.isHidden = true
                    }
                    return
                }

                DispatchQueue.main.async {
                    self.title = searchString
                    self.searchItems = searchItems
                    self.tableView.reloadData()
                    print("reloaded")

                    self.loadingView.isHidden = true
                }
            case .failure(let error):
                if case let .requestFailed(statusCode, message) = error as! HttpError {
                    print("discogsClient.failure: statusCode: \(statusCode) - message: \(message)")
                }

                DispatchQueue.main.async {
                    self.loadingView.isHidden = true
                }
            }
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.resignFirstResponder()
        tableView.reloadData()
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = sender as? IndexPath {
                let searchItem = searchItems[indexPath.row]
                let releaseVC = (segue.destination as! UINavigationController).topViewController as! ReleaseViewController
                releaseVC.searchItem = searchItem
                releaseVC.discogsClient = discogsClient
                releaseVC.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                releaseVC.navigationItem.leftItemsSupplementBackButton = true
                searchController.searchBar.resignFirstResponder()
            }
        }
    }
}
