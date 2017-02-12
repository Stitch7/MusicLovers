//
//  VideoTableViewCell.swift
//  music-lovers
//
//  Created by Christopher Reitz on 09/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!

    var video: Video? {
        didSet {
            guard let video = self.video else { return }

            self.titleLabel.text = video.title
            self.durationLabel.text = video.durationString
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        titleLabel.numberOfLines = 0
        durationLabel.textAlignment = .right
    }
}
