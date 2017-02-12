//
//  HttpError.swift
//  music-lovers
//
//  Created by Christopher Reitz on 08/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

enum HttpError: Error {
    case invalidUrl
    case requestFailed(statusCode: Int, message: String)
    case unknown(Error?)
}
