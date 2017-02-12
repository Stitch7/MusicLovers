//
//  SectionsDataDelegate.swift
//  music-lovers
//
//  Created by Christopher Reitz on 12/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import UIKit

class SectionsDataDelegate<SectionsEnum>: NSObject, UITableViewDelegate where SectionsEnum: SectionsDataEnum {

    // MARK: - Properties

    var object: Any?
    weak var tableView: UITableView?

    var didSelectRowAtIndexPath : ((IndexPath) -> Void)?

    var emptyView: UILabel = {
        let view = UILabel(frame: .zero)
        view.backgroundColor = .clear
        return view
    }()

    var headerViewFontSize: CGFloat = 16.0
    var headerViewHeight: CGFloat = 38.0
    var footerViewHeight: CGFloat = 10.0

    func headerView(title: String) -> UIView {
        guard let tableView = self.tableView else { return emptyView }

        let width = tableView.frame.size.width

        let label = UILabel(frame: CGRect(x: 10, y: 0, width: width, height: headerViewHeight))
        label.backgroundColor = .clear
        label.textColor = .black
        label.text = title.uppercased()
        label.font = UIFont.boldSystemFont(ofSize: headerViewFontSize)

        if let blurEffectView = self.tableView?.backgroundView?.subviews.first as? UIVisualEffectView {
            let vibrancy = UIVibrancyEffect(blurEffect: blurEffectView.effect as! UIBlurEffect)

            let view = UIVisualEffectView(effect: vibrancy)
            view.frame = CGRect(x: 0, y: 0, width: width, height: headerViewHeight)
            view.contentView.addSubview(label)
            return view
        }
        else {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: headerViewHeight))
            view.addSubview(label)
            return view
        }
    }

    var footerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    // MARK: - Initializers

    init(tableView: UITableView, didSelectRowAtIndexPath : ((IndexPath) -> Void)? = nil) {
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0

        super.init()
        tableView.delegate = self
        self.tableView = tableView
        self.didSelectRowAtIndexPath = didSelectRowAtIndexPath
    }

    // UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = SectionsEnum(rawValue: section) else { fatalError("Invalid section") }
        guard let object = self.object else { return 0 }

        let isEmpty = section.numberOfRows(object: object) == 0
        return isEmpty ? 0 : headerViewHeight
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let section = SectionsEnum(rawValue: section) else { fatalError("Invalid section") }
        guard let object = self.object else { return 0 }

        let isEmpty = section.numberOfRows(object: object) == 0
        return isEmpty ? 0 : footerViewHeight
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = SectionsEnum(rawValue: section) else { fatalError("Invalid section") }
        guard let object = self.object else { return nil }
        guard let title = section.name else { return emptyView }

        let isEmpty = section.numberOfRows(object: object) == 0
        return isEmpty ? emptyView : headerView(title: title)
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let section = SectionsEnum(rawValue: section) else { fatalError("Invalid section") }
        guard let object = self.object else { return nil }
        guard section.name != nil else { return emptyView }

        let isEmpty = section.numberOfRows(object: object) == 0
        return isEmpty ? emptyView : footerView
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.superview?.backgroundColor = UIColor.white.withAlphaComponent(0.5)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRowAtIndexPath?(indexPath)
    }
}
