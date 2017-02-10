***REMOVED***
***REMOVED***  ArtistSections.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 10/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import UIKit

enum ArtistSections: Int {
    case profile
    case discography
    case members
    case aliases
    case namevariations
    case urls
***REMOVED***

extension ArtistSections: SectionsDataEnum {

    static let numbersOfSections = 6

    static func setup(tableView: UITableView) {
        tableView.register(UINib(nibName: "ArtistTableViewCell", bundle: nil), forCellReuseIdentifier: "ArtistCell")
        tableView.register(UINib(nibName: "VideoTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoCell")
        tableView.estimatedRowHeight = 21
***REMOVED***

    var name: String? {
        switch self {
        case .profile: return "Profile"
        case .discography: return "Discography"
        case .members: return "Members"
        case .aliases: return "Aliases"
        case .namevariations: return "Name Variations"
        case .urls: return "Links"
    ***REMOVED***
***REMOVED***

    func numberOfRows(object: Any) -> Int {
        guard let artist = object as? Artist else { return 0 ***REMOVED***

        switch self {
        case .members:
            return artist.members?.count ?? 0
        case .aliases:
            return artist.aliases?.count ?? 0
        case .namevariations:
            return artist.namevariations?.count ?? 0
        case .urls:
            return artist.urls?.count ?? 0
        default:
            return 1
    ***REMOVED***
***REMOVED***

    func generateCell(for tableView: UITableView, at indexPath: IndexPath, with object: Any?) -> UITableViewCell {
        guard let artistSection = ArtistSections(rawValue: indexPath.section) else { fatalError("Invalid section") ***REMOVED***
        let artist = object as? Artist
        let cell = generateCell(for: tableView, at: indexPath, with: artist)

        switch artistSection {
        case .profile:
            setupProfileCell(cell: cell, at: indexPath, with: artist)
        case .discography:
            setupDiscographyCell(cell: cell, at: indexPath, with: artist)
        case .members:
            setupMembersCell(cell: cell, at: indexPath, with: artist)
        case .aliases:
            setupAliasesCell(cell: cell, at: indexPath, with: artist)
        case .namevariations:
            setupNamevariationsCell(cell: cell, at: indexPath, with: artist)
        case .urls:
            setupUrlsCell(cell: cell, at: indexPath, with: artist)
    ***REMOVED***
        
        return cell
***REMOVED***

    func generateCell(for tableView: UITableView, at indexPath: IndexPath, with artist: Artist?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.selectionStyle = .none
        cell.accessoryType = .none

        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15.0)
        cell.textLabel?.textColor = .black
        cell.textLabel?.text = nil
        cell.textLabel?.attributedText = nil

        return cell
***REMOVED***

    func setupProfileCell(cell: UITableViewCell, at indexPath: IndexPath, with artist: Artist?) {
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14.0)
        cell.textLabel?.text = artist?.profile
***REMOVED***

    func setupDiscographyCell(cell: UITableViewCell, at indexPath: IndexPath, with artist: Artist?) {
        cell.accessoryType = .disclosureIndicator
        ***REMOVED*** TODO
        cell.textLabel?.textColor = .blue
        cell.textLabel?.text = "Discography"
***REMOVED***

    func setupMembersCell(cell: UITableViewCell, at indexPath: IndexPath, with artist: Artist?) {
        if let member = artist?.members?[indexPath.row] {
            if member.active {
                cell.textLabel?.text = member.name
        ***REMOVED*** else {
                let inactiveName = NSMutableAttributedString(string: member.name)
                inactiveName.addAttribute(NSStrikethroughStyleAttributeName,
                                          value: 1,
                                          range: NSMakeRange(0, inactiveName.length))
                cell.textLabel?.attributedText = inactiveName
        ***REMOVED***
    ***REMOVED***
***REMOVED***

    func setupAliasesCell(cell: UITableViewCell, at indexPath: IndexPath, with artist: Artist?) {
        if let alias = artist?.aliases?[indexPath.row] {
            cell.textLabel?.text = alias.name
    ***REMOVED***

***REMOVED***

    func setupNamevariationsCell(cell: UITableViewCell, at indexPath: IndexPath, with artist: Artist?) {
        if let namevariation = artist?.namevariations?[indexPath.row] {
            cell.textLabel?.text = namevariation
    ***REMOVED***
***REMOVED***

    func setupUrlsCell(cell: UITableViewCell, at indexPath: IndexPath, with artist: Artist?) {
        if let url = artist?.urls?[indexPath.row] {
            cell.textLabel?.text = url.absoluteString
    ***REMOVED***
        cell.accessoryType = .disclosureIndicator
        ***REMOVED*** TODO
        cell.textLabel?.textColor = .blue
***REMOVED***        cell.textLabel?.textColor = view.tintColor
***REMOVED***


***REMOVED***
