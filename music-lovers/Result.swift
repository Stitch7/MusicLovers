//
//  Result.swift
//  music-lovers
//
//  Created by Christopher Reitz on 08/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T?)
    case failure(Error)
}
