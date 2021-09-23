//
//  FollowerCell.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 15/12/2020.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    // MARK: - Declaration
    static let reuseId      = "FollowerCell"

    let avatarImageView     = GFAvatarImageView(frame: .zero)
    let usernameLabel       = GFTitleLabel(textAlignment: .center, fontSize: 16)

    // MARK: - Initialiser
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

   override func layoutSubviews() {
      super.layoutSubviews()
      configureFollowerCell()
   }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Called outside
    func set(on follower: Follower) {
        usernameLabel.text  = follower.login
        avatarImageView.downloadImage(from: follower.avatarUrl)
    }
    
    // MARK: - Layout configrations
    func configureFollowerCell() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint        (equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint    (equalTo: leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint   (equalTo: trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint     (equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint          (equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint      (equalTo: leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint     (equalTo: trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint       (equalToConstant: 20)
        ])
    }
}
