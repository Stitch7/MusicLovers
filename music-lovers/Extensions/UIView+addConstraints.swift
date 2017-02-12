//
//  UIView+addConstraints.swift
//  music-lovers
//
//  Created by Christopher Reitz on 09/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraints(format: String, views: [String : Any]) {
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format,
                                                      options: [],
                                                      metrics: nil,
                                                      views: views))
    }

    func addHorizontallyCenteredConstraints(forView view: UIView, inSuperView superView: UIView) {
        let constraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[superview]-(<=1)-[view]",
            options: .alignAllCenterX,
            metrics: nil,
            views: ["superview": self, "view": view]
        )

        addConstraints(constraints)
    }

    func addVerticallyCenteredConstraints(forView view: UIView, inSuperView superView: UIView) {
        let constraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:[superview]-(<=1)-[view]",
            options: .alignAllCenterY,
            metrics: nil,
            views: ["superview": self, "view": view]
        )

        addConstraints(constraints)
    }
}

extension UIViewController {
    func addConstraints(format: String, views: [String : Any]) {
        view.addConstraints(format: format, views: views)
    }

    func addHorizontallyCenterConstraints(forView view: UIView, inSuperView superView: UIView) {
        view.addHorizontallyCenteredConstraints(forView: view, inSuperView: superView)
    }

    func addVerticallyCenteredConstraints(forView view: UIView, inSuperView superView: UIView) {
        view.addVerticallyCenteredConstraints(forView: view, inSuperView: superView)
    }
}
