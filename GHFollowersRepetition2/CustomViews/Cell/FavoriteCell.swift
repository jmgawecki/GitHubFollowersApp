//
//  Favorite.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 20/12/2020.
//

import UIKit

class FavoriteCell: UITableViewCell {
    // MARK: - Declarations
    
    
    static let reuseId  = "FavoriteCell"
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel   = GFTitleLabel(textAlignment: .left, fontSize: 34)

    
    // MARK: - Initialisers
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    

    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    // MARK: - Called outside
    
    
    func set(on follower: User) {
        avatarImageView.downloadImage(from: follower.avatarUrl)
        usernameLabel.text = follower.login
    }
    
    
    // MARK: - Configurations
    
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        accessoryType           = .disclosureIndicator
        let padding: CGFloat    = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint    (equalTo: centerYAnchor),
            avatarImageView.leadingAnchor.constraint    (equalTo: leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint     (equalToConstant: 60),
            avatarImageView.widthAnchor.constraint      (equalTo: avatarImageView.heightAnchor),
            
            usernameLabel.centerYAnchor.constraint      (equalTo: centerYAnchor),
            usernameLabel.leadingAnchor.constraint      (equalTo: avatarImageView.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint     (equalTo: trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint       (equalToConstant: 40)
        ])
        
    }

}
