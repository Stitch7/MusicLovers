//
//  JSONInitializable.swift
//  music-lovers
//
//  Created by Christopher Reitz on 08/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

typealias JSON = [String: Any]

protocol JSONInitializable {
    init?(json: JSON)
}
