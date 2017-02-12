//
//  NoResultsView.swift
//  music-lovers
//
//  Created by Christopher Reitz on 09/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import UIKit

class NoResultsView: UIView {

    // MARK: - Properties

    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No Results".localized
        label.font = UIFont.systemFont(ofSize: 22.0, weight: UIFontWeightLight)
        label.textColor = .darkGray
        label.textAlignment = .center
        return label
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
        configureSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        isHidden = true
    }

    private func configureSubviews() {
        addSubview(label)

        addVerticallyCenteredConstraints(forView: label, inSuperView: self)
        addHorizontallyCenteredConstraints(forView: label, inSuperView: self)
    }
}
