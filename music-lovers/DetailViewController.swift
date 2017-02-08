***REMOVED***
***REMOVED***  DetailViewController.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 08/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    var searchItem: SearchItem? {
        didSet {
            self.configureView()
    ***REMOVED***
***REMOVED***

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
***REMOVED***

    func configureView() {
        guard
            let label = detailDescriptionLabel,
            let searchItem = self.searchItem
        else { return ***REMOVED***
        label.text = searchItem.title


        guard let url = URL(string: Config.DiscogsApi.BaseUrl) else {
            fatalError("Invalid DiscogsApi.BaseUrl in Config")
    ***REMOVED***

        let credentials = Credentials(key: Config.DiscogsApi.Key, secret: Config.DiscogsApi.Secret)
        let foundationClient = FoundationClient(url: url, credentials: credentials)
        let discogsClient = DiscogsClient(httpClient: foundationClient)

        discogsClient.release(id: searchItem.id) { release in
            dump(release)
    ***REMOVED***
***REMOVED***
***REMOVED***
