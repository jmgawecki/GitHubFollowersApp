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

    fileprivate lazy var avatarImageView: GFAvatarImageView = {
        let imageView = GFAvatarImageView(frame: .zero)
        addSubview(imageView)
        return imageView
    }()
    
    fileprivate lazy var usernameLabel: GFTitleLabel = {
        let label = GFTitleLabel(textAlignment: .center, fontSize: 16)
        addSubview(label)
        return label
    }()

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
    func set(on follower: Follower?) {
        guard let follower = follower else {
            return
        }
        usernameLabel.text  = follower.login
        avatarImageView.downloadImage(from: follower.avatarUrl, imageSize: .medium)
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
