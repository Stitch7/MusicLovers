***REMOVED***
***REMOVED***  VideoTableViewCell.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 09/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!

    var video: Video? {
        didSet {
            guard let video = self.video else { return ***REMOVED***

            self.titleLabel.text = video.title
            self.durationLabel.text = toMinutesString(seconds: video.duration)
    ***REMOVED***
***REMOVED***

    func toMinutesString(seconds: Int) -> String {
        let m = (seconds % 3600) / 60
        let mFormatted = String(m).leftPadding(toLength: 2, withPad: "0")

        let s = (seconds % 3600) % 60
        let sFormatted = String(s).leftPadding(toLength: 2, withPad: "0")

        return "\(mFormatted):\(sFormatted)"
***REMOVED***

    override func awakeFromNib() {
        super.awakeFromNib()

        titleLabel.numberOfLines = 0
        durationLabel.textAlignment = .right
***REMOVED***
***REMOVED***
