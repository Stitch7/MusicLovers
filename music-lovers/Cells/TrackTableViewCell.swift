***REMOVED***
***REMOVED***  TrackTableViewCell.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 09/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import UIKit

class TrackTableViewCell: UITableViewCell {

    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!

    var track: Track? {
        didSet {
            guard let track = self.track else { return ***REMOVED***

            self.positionLabel.text = track.position
            self.titleLabel.text = track.title
            self.durationLabel.text = track.duration
    ***REMOVED***
***REMOVED***
    
    override func awakeFromNib() {
        super.awakeFromNib()

        positionLabel.textAlignment = .right
        positionLabel.textColor = .darkGray

        durationLabel.textAlignment = .right
        durationLabel.textColor = .darkGray
***REMOVED***
***REMOVED***
