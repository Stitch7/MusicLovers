//
//  SearchItemTableViewCell.swift
//  music-lovers
//
//  Created by Christopher Reitz on 09/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import UIKit

class SearchItemTableViewCell: UITableViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var labelLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var countryYearLabel: UILabel!
    
    var searchItem: SearchItem? {
        didSet {
            guard let searchItem = self.searchItem else { return }

            titleLabel.text = searchItem.title
            labelLabel.text = Array(Set(searchItem.label)).joined(separator: ", ")
            genreLabel.text = searchItem.genre.joined(separator: ", ")
            countryYearLabel.text = searchItem.country + ", " + searchItem.year
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        accessoryType = .disclosureIndicator

        coverImageView.contentMode = .scaleAspectFit

        titleLabel.numberOfLines = 0
        labelLabel.numberOfLines = 3
    }
}
