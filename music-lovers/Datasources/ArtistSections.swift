//
//  ArtistSections.swift
//  music-lovers
//
//  Created by Christopher Reitz on 10/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import UIKit

enum ArtistSections: Int {
    case profile
    case discography
    case members
    case aliases
    case namevariations
    case urls
}

extension ArtistSections: SectionsDataEnum {

    static let numbersOfSections = 6

    static func setup(tableView: UITableView) {
        tableView.register(UINib(nibName: "ArtistTableViewCell", bundle: nil), forCellReuseIdentifier: "ArtistCell")
        tableView.register(UINib(nibName: "VideoTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoCell")
        tableView.estimatedRowHeight = 21
    }

    var name: String? {
        switch self {
        case .profile: return "Profile".localized
        case .discography: return "Discography".localized
        case .members: return "Members".localized
        case .aliases: return "Aliases".localized
        case .namevariations: return "Name Variations".localized
        case .urls: return "Links".localized
        }
    }

    func numberOfRows(object: Any) -> Int {
        guard let artist = object as? Artist else { return 0 }

        switch self {
        case .profile: return (artist.profile?.characters.count ?? 0) > 0 ? 1 : 0
        case .discography: return 1
        case .members: return artist.members?.count ?? 0
        case .aliases: return artist.aliases?.count ?? 0
        case .namevariations: return artist.namevariations?.count ?? 0
        case .urls: return artist.urls?.count ?? 0
        }
    }

    func generateCell(for tableView: UITableView, at indexPath: IndexPath, with object: Any?) -> UITableViewCell {
        guard let artistSection = ArtistSections(rawValue: indexPath.section) else { fatalError("Invalid section") }
        let artist = object as? Artist
        let cell = generateCell(for: tableView, at: indexPath, with: artist)

        switch artistSection {
        case .profile: setupProfileCell(cell: cell, at: indexPath, with: artist)
        case .discography: setupDiscographyCell(cell: cell, at: indexPath, with: artist)
        case .members: setupMembersCell(cell: cell, at: indexPath, with: artist)
        case .aliases: setupAliasesCell(cell: cell, at: indexPath, with: artist)
        case .namevariations: setupNamevariationsCell(cell: cell, at: indexPath, with: artist)
        case .urls: setupUrlsCell(cell: cell, at: indexPath, with: artist)
        }
        
        return cell
    }

    func generateCell(for tableView: UITableView, at indexPath: IndexPath, with artist: Artist?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.accessoryType = .none
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15.0)
        cell.textLabel?.textColor = .black
        cell.textLabel?.text = nil
        cell.textLabel?.attributedText = nil

        return cell
    }

    func setupProfileCell(cell: UITableViewCell, at indexPath: IndexPath, with artist: Artist?) {
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14.0)
        cell.textLabel?.text = artist?.profile
    }

    func setupDiscographyCell(cell: UITableViewCell, at indexPath: IndexPath, with artist: Artist?) {
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.textColor = UIApplication.tintColor
        cell.textLabel?.text = "Discography".localized
    }

    func setupMembersCell(cell: UITableViewCell, at indexPath: IndexPath, with artist: Artist?) {
        guard let member = artist?.members?[indexPath.row] else { return }

        if member.active {
            cell.textLabel?.text = member.name
        } else {
            let inactiveName = NSMutableAttributedString(string: member.name)
            inactiveName.addAttribute(NSStrikethroughStyleAttributeName,
                                      value: 1,
                                      range: NSMakeRange(0, inactiveName.length))
            cell.textLabel?.attributedText = inactiveName
        }
    }

    func setupAliasesCell(cell: UITableViewCell, at indexPath: IndexPath, with artist: Artist?) {
        cell.textLabel?.text = artist?.aliases?[indexPath.row].name
    }

    func setupNamevariationsCell(cell: UITableViewCell, at indexPath: IndexPath, with artist: Artist?) {
        cell.textLabel?.text = artist?.namevariations?[indexPath.row]
    }

    func setupUrlsCell(cell: UITableViewCell, at indexPath: IndexPath, with artist: Artist?) {
        if let url = artist?.urls?[indexPath.row] {
            cell.textLabel?.text = url.absoluteString
        }
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.textColor = UIApplication.tintColor
    }
}
