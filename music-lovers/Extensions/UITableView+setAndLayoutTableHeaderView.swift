//
//  UITableView+setAndLayoutTableHeaderView.swift
//  music-lovers
//
//  Created by Christopher Reitz on 10/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import UIKit

extension UITableView {
    // Set the tableHeaderView so that the required height can be determined, update the header's frame and set it again
    func setAndLayoutTableHeaderView(header: UIView, maxHeight: CGFloat? = nil) {
        tableHeaderView = header
        header.setNeedsLayout()
        header.layoutIfNeeded()

        var height = header.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        if let maxHeight = maxHeight {
            if height > maxHeight {
                height = maxHeight
            }
        }

        var frame = header.frame
        frame.size.height = height
        header.frame = frame
        tableHeaderView = header
    }
}
