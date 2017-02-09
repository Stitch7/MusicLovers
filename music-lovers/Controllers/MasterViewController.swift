***REMOVED***
***REMOVED***  MasterViewController.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 08/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import UIKit

class MasterViewController: UITableViewController {

    ***REMOVED*** MARK: - Properties

    var detailViewController: DetailViewController? = nil
    var searchItems = [SearchItem]()
    var cache = NSCache<NSNumber, UIImage>()

    ***REMOVED*** MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        configureDetailViewController()
        configureNavigationBar()
        configureTableView()

        guard let url = URL(string: Config.DiscogsApi.BaseUrl) else {
            fatalError("Invalid DiscogsApi.BaseUrl in Config")
    ***REMOVED***

        let credentials = Credentials(key: Config.DiscogsApi.Key, secret: Config.DiscogsApi.Secret)
        let foundationClient = FoundationClient(url: url, credentials: credentials)
        let discogsClient = DiscogsClient(httpClient: foundationClient)

        let searchString = "Bambule"

        discogsClient.search(title: searchString) { result in
            switch result {
            case .success(let items):
                 ***REMOVED*** TODO: why optional?
                guard let searchItems = items else { return ***REMOVED***

                DispatchQueue.main.async {
                    self.searchItems = searchItems
                    self.tableView.reloadData()
                    print("reloaded")
            ***REMOVED***
            case .failure(let error):
                if case let .requestFailed(statusCode, message) = error as! HttpError {
                    print("discogsClient.failure: statusCode: \(statusCode) - message: \(message)")
            ***REMOVED***
        ***REMOVED***
    ***REMOVED***
***REMOVED***

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
***REMOVED***

    func configureDetailViewController() {
        guard let split = self.splitViewController else { return ***REMOVED***

        let controllers = split.viewControllers
        let navigationVC = controllers[controllers.count-1] as! UINavigationController
        self.detailViewController = navigationVC.topViewController as? DetailViewController
***REMOVED***

    func configureNavigationBar() {
        title = "Music Lovers"
***REMOVED***

    func configureTableView() {
        tableView.register(UINib(nibName: "SearchItemTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchItemCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
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
        performSegue(withIdentifier: "showDetail", sender: indexPath)
***REMOVED***

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchItems.count
***REMOVED***

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchItemCell", for: indexPath) as! SearchItemTableViewCell
        let key = NSNumber(integerLiteral: indexPath.row)

        cell.accessoryType = .disclosureIndicator

        let searchItem = searchItems[indexPath.row]

        cell.searchItem = searchItem

        cell.coverImageView?.contentMode = .scaleAspectFit

        if let cachedImage = cache.object(forKey: key) {
            print("Cached image used")
            cell.coverImageView?.image = cachedImage
    ***REMOVED*** else {
            cell.coverImageView?.image = UIImage(named: "default-release")
            downloadFrom(url: searchItem.thumb) { data in
                guard
                    let imageData = data,
                    let image = UIImage(data: imageData)
                else { return ***REMOVED***

                self.cache.setObject(image, forKey: key)

                if let updateCell = tableView.cellForRow(at: indexPath) as? SearchItemTableViewCell {
                    updateCell.coverImageView?.image = image
            ***REMOVED***
        ***REMOVED***
    ***REMOVED***

        return cell
***REMOVED***

    func downloadFrom(url: URL, completion completionHandler: @escaping (Data?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
***REMOVED***            sleep(1)
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

    ***REMOVED*** MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = sender as? IndexPath {
                let searchItem = searchItems[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.searchItem = searchItem
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
        ***REMOVED***
    ***REMOVED***
***REMOVED***
***REMOVED***
