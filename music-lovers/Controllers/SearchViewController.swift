***REMOVED***
***REMOVED***  SearchViewController.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 08/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import UIKit

class SearchViewController: UITableViewController, UISearchBarDelegate {

    ***REMOVED*** MARK: - Properties

    var discogsClient: DiscogsClient = {
        guard let url = URL(string: Config.DiscogsApi.BaseUrl) else {
            fatalError("Invalid DiscogsApi.BaseUrl in Config")
    ***REMOVED***

        let credentials = Credentials(key: Config.DiscogsApi.Key, secret: Config.DiscogsApi.Secret)
        let foundationClient = FoundationClient(url: url, credentials: credentials)
        return DiscogsClient(httpClient: foundationClient)
***REMOVED***()

    var detailViewController: ReleaseViewController? = nil
    let searchController = UISearchController(searchResultsController: nil)

    let searchHistoryKey = "searchHistory"
    var searchHistory = NSMutableArray()
    let userDefaults = UserDefaults.standard
    var searchItems = [SearchItem]()
    var cache = NSCache<NSString, UIImage>()

    let loadingView = LoadingView()
    let noResultsView = NoResultsView()

    ***REMOVED*** MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        configureDetailViewController()
        configureNavigationBar()
        configureTableView()
        configureLoadingView()
        configureNoResultsView()
***REMOVED***

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
***REMOVED***

    func configureDetailViewController() {
        guard let split = self.splitViewController else { return ***REMOVED***

        let controllers = split.viewControllers
        let navigationVC = controllers[controllers.count-1] as! UINavigationController
        self.detailViewController = navigationVC.topViewController as? ReleaseViewController
***REMOVED***

    func configureNavigationBar() {
        title = "Music Lovers"
***REMOVED***

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
        tableView.tableHeaderView = searchController.searchBar

        searchHistory = userDefaults.mutableArrayValue(forKey: searchHistoryKey)
***REMOVED***

    func configureLoadingView() {
        searchController.view.addSubview(loadingView)

        let views =  ["loadingView": loadingView]
        searchController.view.addConstraints(format: "V:|[loadingView]|", views: views)
        searchController.view.addConstraints(format: "H:|[loadingView]|", views: views)
***REMOVED***

    func configureNoResultsView() {
        searchController.view.addSubview(noResultsView)

        let views =  ["noResultsView": noResultsView]
        searchController.view.addConstraints(format: "V:|[noResultsView]|", views: views)
        searchController.view.addConstraints(format: "H:|[noResultsView]|", views: views)
***REMOVED***

    ***REMOVED*** MARK: - Table View

***REMOVED***    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
***REMOVED***        return UITableViewAutomaticDimension
***REMOVED******REMOVED***
***REMOVED***
***REMOVED***    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
***REMOVED***        return UITableViewAutomaticDimension
***REMOVED******REMOVED***

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard searchController.isActive else { return ***REMOVED***
        performSegue(withIdentifier: "showDetail", sender: indexPath)
***REMOVED***

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive ? searchItems.count : searchHistory.count
***REMOVED***

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard searchController.isActive else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            if searchHistory.count > indexPath.row {
                cell.textLabel?.text = searchHistory.object(at: indexPath.row) as? String
        ***REMOVED***
            return cell
    ***REMOVED***

        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchItemCell", for: indexPath) as! SearchItemTableViewCell

        let searchItem = searchItems[indexPath.row]
        cell.searchItem = searchItem

        let cacheKey = NSString(string: searchItem.thumb.absoluteString)
        if let cachedImage = cache.object(forKey: cacheKey) {
            print("Cached image used")
            cell.coverImageView?.image = cachedImage
    ***REMOVED*** else {
            cell.coverImageView?.image = UIImage(named: "default-release")
            downloadFrom(url: searchItem.thumb) { data in
                guard
                    let imageData = data,
                    let image = UIImage(data: imageData)
                else { return ***REMOVED***

                self.cache.setObject(image, forKey: cacheKey)

                if let updateCell = tableView.cellForRow(at: indexPath) as? SearchItemTableViewCell {
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
                print("download completed \(url.lastPathComponent)")
                completionHandler(data)
        ***REMOVED***
    ***REMOVED***.resume()
***REMOVED***

    ***REMOVED*** MARK: - UISearchBarDelegate

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchString = searchController.searchBar.text else { return ***REMOVED***

        noResultsView.isHidden = true
        loadingView.isHidden = false

        discogsClient.search(title: searchString) { result in
            switch result {
            case .success(let items):
                guard let searchItems = items, searchItems.count > 0 else {
                    DispatchQueue.main.async {
                        self.noResultsView.isHidden = false
                        self.loadingView.isHidden = true
                ***REMOVED***
                    return
            ***REMOVED***

                DispatchQueue.main.async {
                    self.title = searchString
                    self.searchItems = searchItems
                    self.tableView.reloadData()
                    print("reloaded")

                    self.loadingView.isHidden = true

                    ***REMOVED*** Update searchHistory
***REMOVED***                    let newSearchHistory = NSMutableArray()
***REMOVED***                    newSearchHistory.add(searchString)
***REMOVED***                    newSearchHistory.add(self.searchHistory)
***REMOVED***
***REMOVED***                    self.userDefaults.set(newSearchHistory, forKey: self.searchHistoryKey)
***REMOVED***                    self.searchHistory = newSearchHistory
            ***REMOVED***
            case .failure(let error):
                if case let .requestFailed(statusCode, message) = error as! HttpError {
                    print("discogsClient.failure: statusCode: \(statusCode) - message: \(message)")
            ***REMOVED***

                DispatchQueue.main.async {
                    self.loadingView.isHidden = true
            ***REMOVED***
        ***REMOVED***
    ***REMOVED***
***REMOVED***

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.resignFirstResponder()
        tableView.reloadData()
***REMOVED***

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
***REMOVED***

    ***REMOVED*** MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = sender as? IndexPath {
                let searchItem = searchItems[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! ReleaseViewController
                controller.searchItem = searchItem
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                searchController.searchBar.resignFirstResponder()
        ***REMOVED***
    ***REMOVED***
***REMOVED***
***REMOVED***
