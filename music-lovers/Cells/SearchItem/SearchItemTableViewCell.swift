***REMOVED***
***REMOVED***  SearchItemTableViewCell.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 09/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import UIKit

class SearchItemTableViewCell: UITableViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var labelLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var countryYearLabel: UILabel!
    
    var searchItem: SearchItem? {
        didSet {
            guard let searchItem = self.searchItem else { return ***REMOVED***

            self.titleLabel.text = searchItem.title
            self.labelLabel.text = Array(Set(searchItem.label)).joined(separator: ", ")
            self.genreLabel.text = searchItem.genre.joined(separator: ", ")
            self.countryYearLabel.text = searchItem.country + ", " + searchItem.year
    ***REMOVED***
***REMOVED***

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.titleLabel.numberOfLines = 0
        self.labelLabel.numberOfLines = 3
***REMOVED***
***REMOVED***