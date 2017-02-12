//
//  UIImage+downloadFrom.swift
//  music-lovers
//
//  Created by Christopher Reitz on 10/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import UIKit

extension UIImage {
    static func downloadFrom(url: URL, completion completionHandler: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("error on download \(error!)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("statusCode != 200")
                return
            }

            let image = UIImage(data: data)
            DispatchQueue.main.async {
                completionHandler(image)
            }
        }.resume()
    }
}
