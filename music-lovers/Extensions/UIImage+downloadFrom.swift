***REMOVED***
***REMOVED***  UIImage+downloadFrom.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 10/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import UIKit

extension UIImage {
    static func downloadFrom(url: URL, completion completionHandler: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("error on download \(error!)")
                return
        ***REMOVED***
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("statusCode != 200")
                return
        ***REMOVED***

            let image = UIImage(data: data)
            DispatchQueue.main.async {
                completionHandler(image)
        ***REMOVED***
    ***REMOVED***.resume()
***REMOVED***
***REMOVED***
