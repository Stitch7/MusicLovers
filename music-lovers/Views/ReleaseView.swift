***REMOVED***
***REMOVED***  ReleaseView.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 09/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import UIKit

 ***REMOVED*** TODO: fix layout grows auto layout prob

class ReleaseView: UIView {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var labelsLabel: UILabel!
    @IBOutlet weak var formatsLabel: UILabel!
    @IBOutlet weak var releasedLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!

    var release: Release? {
        didSet {
            guard let release = self.release else { return ***REMOVED***

            labelsLabel.text = Array(Set(release.labels.map{ $0.name ***REMOVED***)).joined(separator: "\n")
            formatsLabel.text = release.formats.map{ $0.name ***REMOVED***.joined(separator: ", ")
            releasedLabel.text = "\(release.country), \(release.year)"
            genreLabel.text = release.genres.joined(separator: ", ")

            loadImage(url: release.mainImage?.uri)
    ***REMOVED***
***REMOVED***

    override func awakeFromNib() {
        super.awakeFromNib()

        coverImageView.image = UIImage(named: "default-release")

        labelsLabel.text = ""
        formatsLabel.text = ""
        releasedLabel.text = ""
        genreLabel.text = ""

        labelsLabel.numberOfLines = 0
        formatsLabel.numberOfLines = 0
        releasedLabel.numberOfLines = 0
        genreLabel.numberOfLines = 0
***REMOVED***

    func loadImage(url: URL?) {
        guard let imageUrl = url else { return ***REMOVED***

        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            guard
                error == nil,
                let data = data,
                let image = UIImage(data: data)
                else {
                    print("error on download \(error!)")
                    return
        ***REMOVED***

            DispatchQueue.main.async {
                self.coverImageView.image = image
        ***REMOVED***
    ***REMOVED***.resume()
***REMOVED***
***REMOVED***
