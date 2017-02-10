***REMOVED***
***REMOVED***  ArtistDataSource.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 10/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import UIKit

class SectionsDataSource<SectionsEnum>: NSObject, UITableViewDataSource where SectionsEnum: SectionsDataEnum {

    ***REMOVED*** MARK: - Properties

    var object: Any?

    init(tableView: UITableView) {
        tableView.rowHeight = UITableViewAutomaticDimension
        SectionsEnum.setup(tableView: tableView)
***REMOVED***

    ***REMOVED*** MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SectionsEnum(rawValue: section)?.name
***REMOVED***

    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionsEnum.numbersOfSections
***REMOVED***

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let object = self.object, let sectionsEnum = SectionsEnum(rawValue: section) else { return 0 ***REMOVED***
        return sectionsEnum.numberOfRows(object: object)
***REMOVED***

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionsEnum = SectionsEnum(rawValue: indexPath.section) else { fatalError("Invalid section") ***REMOVED***
        return sectionsEnum.generateCell(for: tableView, at: indexPath, with: object)
***REMOVED***
***REMOVED***
