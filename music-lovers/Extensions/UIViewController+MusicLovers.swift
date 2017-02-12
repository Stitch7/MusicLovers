//
//  UIViewController+MusicLovers.swift
//  music-lovers
//
//  Created by Christopher Reitz on 11/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import UIKit

extension UIViewController {
    func configure(loadingView: LoadingView) {
        navigationController?.view.addSubview(loadingView)

        let views =  ["loadingView": loadingView]
        navigationController?.view.addConstraints(format: "V:|[loadingView]|", views: views)
        navigationController?.view.addConstraints(format: "H:|[loadingView]|", views: views)
    }
}
