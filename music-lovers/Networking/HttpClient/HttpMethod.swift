//
//  HttpMethod.swift
//  music-lovers
//
//  Created by Christopher Reitz on 08/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

enum HttpMethod<Body> {
    case get
    case post(Body)
}

extension HttpMethod {
    var string: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        }
    }

    func map<T>(f: (Body) -> T) -> HttpMethod<T> {
        switch self {
        case .get: return .get
        case .post(let body):
            return .post(f(body))
        }
    }
}
