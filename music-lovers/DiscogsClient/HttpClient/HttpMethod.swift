***REMOVED***
***REMOVED***  HttpMethod.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 08/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

enum HttpMethod<Body> {
    case get
    case post(Body)
***REMOVED***

extension HttpMethod {
    var string: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
    ***REMOVED***
***REMOVED***

    func map<T>(f: (Body) -> T) -> HttpMethod<T> {
        switch self {
        case .get: return .get
        case .post(let body):
            return .post(f(body))
    ***REMOVED***
***REMOVED***
***REMOVED***
