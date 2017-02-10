***REMOVED***
***REMOVED***  NoResultsView.swift
***REMOVED***  music-lovers
***REMOVED***
***REMOVED***  Created by Christopher Reitz on 09/02/2017.
***REMOVED***  Copyright © 2017 Christopher Reitz. All rights reserved.
***REMOVED***

import UIKit

class NoResultsView: UIView {

    ***REMOVED*** MARK: - Properties

    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No Results"
        label.font = UIFont.systemFont(ofSize: 22.0, weight: UIFontWeightLight)
        label.textColor = .darkGray
        label.textAlignment = .center
        return label
***REMOVED***()

    ***REMOVED*** MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
        configureSubviews()
***REMOVED***

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
***REMOVED***

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        isHidden = true
***REMOVED***

    private func configureSubviews() {
        addSubview(label)

        addVerticallyCenteredConstraints(forView: label, inSuperView: self)
        addHorizontallyCenteredConstraints(forView: label, inSuperView: self)
***REMOVED***
***REMOVED***
