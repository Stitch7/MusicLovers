//
//  LoadingView.swift
//  music-lovers
//
//  Created by Christopher Reitz on 09/02/2017.
//  Copyright © 2017 Christopher Reitz. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    // MARK: - Properties

    var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = false
        spinner.isHidden = false
        spinner.startAnimating()
        return spinner
    }()

    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Loading".localized.uppercased()
        label.font = UIFont.systemFont(ofSize: 13.0)
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
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)

        let containerViews = ["containerView": containerView]
        addConstraints(format: "V:|[containerView]|", views: containerViews)
        addConstraints(format: "H:|[containerView]|", views: containerViews)

        containerView.addSubview(spinner)
        containerView.addSubview(label)

        let subViews: [String: Any] = [
            "spinner": spinner,
            "label": label
        ]
        containerView.addVerticallyCenteredConstraints(forView: spinner, inSuperView: containerView)
        containerView.addConstraints(format: "V:[spinner]-7-[label]", views: subViews)
        containerView.addHorizontallyCenteredConstraints(forView: spinner, inSuperView: containerView)
        containerView.addHorizontallyCenteredConstraints(forView: label, inSuperView: containerView)
    }

    func remove() {
        DispatchQueue.main.async {
            self.isHidden = true
        }
    }
}
