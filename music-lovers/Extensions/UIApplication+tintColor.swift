//
//  UIApplication+tintColor.swift
//  music-lovers
//
//  Created by Christopher Reitz on 11/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import UIKit

extension UIApplication {
    static var tintColor: UIColor? {
        return UIApplication.shared.delegate?.window??.rootViewController?.view.tintColor
    }
}
