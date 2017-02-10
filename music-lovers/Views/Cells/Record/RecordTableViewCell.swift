***REMOVED***
***REMOVED***  RecordTableViewCell.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 10/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import UIKit

class RecordTableViewCell: UITableViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var labelLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var countryYearLabel: UILabel!
    
    var record: Record? {
        didSet {
            guard let record = self.record else { return ***REMOVED***

            titleLabel.text = record.title
            labelLabel.text = record.label
            genreLabel.text = record.role
            countryYearLabel.text = "\(record.year)"
    ***REMOVED***
***REMOVED***

    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
        accessoryType = .none

        coverImageView.contentMode = .scaleAspectFit

        titleLabel.numberOfLines = 0
        labelLabel.numberOfLines = 3
***REMOVED***
***REMOVED***
