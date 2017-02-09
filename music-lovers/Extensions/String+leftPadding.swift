***REMOVED***
***REMOVED***  String+leftPadding.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 09/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import Foundation

extension String {
    func leftPadding(toLength: Int, withPad character: Character) -> String {
        let newLength = self.characters.count
        if newLength < toLength {
            return String(repeatElement(character, count: toLength - newLength)) + self
    ***REMOVED*** else {
            return self.substring(from: index(self.startIndex, offsetBy: newLength - toLength))
    ***REMOVED***
***REMOVED***
***REMOVED***
