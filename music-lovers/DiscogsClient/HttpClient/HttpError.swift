***REMOVED***
***REMOVED***  HttpError.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 08/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

enum HttpError: Error {
    case requestFailed(statusCode: Int, message: String)
    case unknown(Error?)
***REMOVED***
