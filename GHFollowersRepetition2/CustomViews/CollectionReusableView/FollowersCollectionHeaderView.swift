//
//  FollowersCollectionHeaderView.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 03/02/2021.
//

import UIKit

class FollowersCollectionHeaderView: UICollectionReusableView {
    static let reuseId      = "FollowersCollectionHeaderView"
    
    let avatarImageView     = GFAvatarImageView(frame: .zero)
    let usernameLabel       = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel           = GFSecondaryTitleLabel(fontSize: 18)
    let locationImageView   = UIImageView(frame: .zero)
    let locationLabel       = GFSecondaryTitleLabel(fontSize: 18)
    let bioLabel            = GFBodyLabel(textAlignment: .left)
    
    var user: User!
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        layoutUI()
        configureUIElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(with user: User) {
        avatarImageView.downloadImage(from: user.avatarUrl)
        usernameLabel.text              = user.login
        nameLabel.text                  = user.name ?? ""
        locationLabel.text              = user.location ?? "No location"
        bioLabel.text                   = user.bio ?? "No bio available"
    }
    
    private func configureUIElements() {
        bioLabel.numberOfLines          = 3
        locationImageView.image         = UIImage(systemName: SFSymbols.location)
        locationImageView.tintColor     = .systemGreen
    }
    
    
    private func addSubviews() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        addSubview(nameLabel)
        addSubview(locationImageView)
        addSubview(locationLabel)
        addSubview(bioLabel)
    }
    
    
    private func layoutUI() {
        let outsidePadding:     CGFloat = 13
        let padding:            CGFloat = 20
        let textImagePadding:   CGFloat = 12
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: outsidePadding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
}
