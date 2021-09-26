//
//  GFEmptyStateView.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 16/12/2020.
//

import UIKit

class GFEmptyStateView: UIView {
    // MARK: - Declarations
    fileprivate lazy var messageLabel: GFTitleLabel = {
        let label = GFTitleLabel(textAlignment: .center, fontSize: 28)
        addSubview(label)
        label.numberOfLines = 3
        label.textColor = .secondaryLabel
        return label
    }()
    
    fileprivate lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        imageView.image = UIImage(named: "empty-state-logo")
        return imageView
    }()

    // MARK: - Initialisers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    // MARK: - Configurations
    private func configure() {
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint   (equalTo: self.centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint   (equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint  (equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint    (equalToConstant: 200),
            
            logoImageView.widthAnchor.constraint    (equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint   (equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint (equalTo: self.trailingAnchor, constant: 170),
            logoImageView.bottomAnchor.constraint   (equalTo: self.bottomAnchor, constant: 40)
        ])
    }
}
