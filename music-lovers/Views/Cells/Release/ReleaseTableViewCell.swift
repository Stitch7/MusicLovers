//
//  ReleaseTableViewCell.swift
//  music-lovers
//
//  Created by Christopher Reitz on 10/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import UIKit

class ReleaseTableViewCell: UITableViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var labelsLabel: UILabel!
    @IBOutlet weak var labelsValueLabel: UILabel!
    @IBOutlet weak var formatsLabel: UILabel!
    @IBOutlet weak var formatsValueLabel: UILabel!
    @IBOutlet weak var releasedLabel: UILabel!
    @IBOutlet weak var releasedValueLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var genreValueLabel: UILabel!

    var release: Release? {
        didSet {
            guard let release = self.release else { return }

            labelsValueLabel.text = Array(Set(release.labels.map{ $0.name })).joined(separator: "\n")
            formatsValueLabel.text = release.formats.map{ $0.name }.joined(separator: ", ")
            releasedValueLabel.text = "\(release.country), \(release.year)"
            genreValueLabel.text = release.genres.joined(separator: ", ")

            if let imageUrl = release.mainImage?.uri {
                UIImage.downloadFrom(url: imageUrl) { image in
                    self.coverImageView.image = image
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        coverImageView.image = UIImage(named: "default-release")

        labelsLabel.text = "Labels:"
        formatsLabel.text = "Formats:"
        releasedLabel.text = "Release:"
        genreLabel.text = "Genre:"

        labelsLabel.textAlignment = .right
        formatsLabel.textAlignment = .right
        releasedLabel.textAlignment = .right
        genreLabel.textAlignment = .right

        labelsLabel.textColor = .darkGray
        formatsLabel.textColor = .darkGray
        releasedLabel.textColor = .darkGray
        genreLabel.textColor = .darkGray

        labelsValueLabel.text = ""
        formatsValueLabel.text = ""
        releasedValueLabel.text = ""
        genreValueLabel.text = ""

        labelsValueLabel.numberOfLines = 0
        formatsValueLabel.numberOfLines = 0
        releasedValueLabel.numberOfLines = 0
        genreValueLabel.numberOfLines = 0
    }
}
