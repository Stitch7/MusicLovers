//
//  ArtistDataSource.swift
//  music-lovers
//
//  Created by Christopher Reitz on 10/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import UIKit

class SectionsDataSource<SectionsEnum>: NSObject, UITableViewDataSource where SectionsEnum: SectionsDataEnum {

    // MARK: - Properties

    var object: Any?

    init(tableView: UITableView) {
        tableView.rowHeight = UITableViewAutomaticDimension
        SectionsEnum.setup(tableView: tableView)

        super.init()
        tableView.dataSource = self
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SectionsEnum(rawValue: section)?.name
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionsEnum.numbersOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let object = self.object, let sectionsEnum = SectionsEnum(rawValue: section) else { return 0 }
        return sectionsEnum.numberOfRows(object: object)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionsEnum = SectionsEnum(rawValue: indexPath.section) else { fatalError("Invalid section") }
        return sectionsEnum.generateCell(for: tableView, at: indexPath, with: object)
    }
}
