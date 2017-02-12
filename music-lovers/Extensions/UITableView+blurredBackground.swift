//
//  UITableView+blurredBackground.swift
//  music-lovers
//
//  Created by Christopher Reitz on 13/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import UIKit

extension UITableView {
    func setBlurredBackground(image: UIImage) {
        let coverImageView = UIImageView(image: image)
        coverImageView.contentMode = .scaleAspectFill

        let blur = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: blur)
        effectView.translatesAutoresizingMaskIntoConstraints = false

        coverImageView.addSubview(effectView)

        let views =  ["effectView": effectView]
        coverImageView.addConstraints(format: "V:|[effectView]|", views: views)
        coverImageView.addConstraints(format: "H:|[effectView]|", views: views)

        backgroundView = coverImageView
        separatorEffect = UIVibrancyEffect(blurEffect: blur)
        reloadData()
    }
}
