//
//  TrackTableViewCell.swift
//  music-lovers
//
//  Created by Christopher Reitz on 09/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import UIKit

class TrackTableViewCell: UITableViewCell {

    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!

    var track: Track? {
        didSet {
            guard let track = self.track else { return }

            self.positionLabel.text = track.position
            self.titleLabel.text = track.title
            self.durationLabel.text = track.duration
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none

        positionLabel.textAlignment = .right
        positionLabel.textColor = .darkGray

        durationLabel.textAlignment = .right
        durationLabel.textColor = .darkGray
    }
}
