***REMOVED***
***REMOVED***  SectionsDataEnum.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 10/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import UIKit

protocol SectionsDataEnum {
    static var numbersOfSections: Int { get ***REMOVED***
    static func setup(tableView: UITableView)
    init?(rawValue: Int)
    var name: String? { get ***REMOVED***
    func numberOfRows(object: Any) -> Int
    func generateCell(for tableView: UITableView, at indexPath: IndexPath, with object: Any?) -> UITableViewCell
***REMOVED***
