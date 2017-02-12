//
//  String+leftPadding.swift
//  music-lovers
//
//  Created by Christopher Reitz on 09/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import Foundation

extension String {
    func leftPadding(toLength: Int, withPad character: Character) -> String {
        let newLength = self.characters.count
        if newLength < toLength {
            return String(repeatElement(character, count: toLength - newLength)) + self
        }

        return self.substring(from: index(self.startIndex, offsetBy: newLength - toLength))
    }
}
