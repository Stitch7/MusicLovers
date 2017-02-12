//
//  SectionsDataEnum.swift
//  music-lovers
//
//  Created by Christopher Reitz on 10/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import UIKit

protocol SectionsDataEnum {
    static var numbersOfSections: Int { get }
    static func setup(tableView: UITableView)
    init?(rawValue: Int)
    var name: String? { get }
    func numberOfRows(object: Any) -> Int
    func generateCell(for tableView: UITableView, at indexPath: IndexPath, with object: Any?) -> UITableViewCell
}
