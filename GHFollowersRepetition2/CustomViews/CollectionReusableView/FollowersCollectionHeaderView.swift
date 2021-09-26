//
//  FollowersCollectionHeaderView.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 03/02/2021.
//

import UIKit

class FollowersCollectionHeaderView: UICollectionReusableView {
    //MARK: - Declarations
    static let reuseId      = "FollowersCollectionHeaderView"
    
    fileprivate lazy var avatarImageView: GFAvatarImageView = {
        let imageView = GFAvatarImageView(frame: .zero)
        addSubview(imageView)
        return imageView
    }()
    
    fileprivate lazy var usernameLabel: GFTitleLabel = {
        let label = GFTitleLabel(textAlignment: .left, fontSize: 34)
        addSubview(label)
        return label
    }()
    
    fileprivate lazy var nameLabel: GFSecondaryTitleLabel = {
        let label = GFSecondaryTitleLabel(fontSize: 18)
        addSubview(label)
        return label
    }()
    
    fileprivate lazy var locationImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        imageView.image = UIImage(systemName: SFSymbols.location)
        imageView.tintColor = .systemGreen
        return imageView
    }()
    
    fileprivate lazy var locationLabel: GFSecondaryTitleLabel = {
        let label = GFSecondaryTitleLabel(fontSize: 18)
        addSubview(label)
        return label
    }()
    
    private lazy var bioLabel: GFBodyLabel = {
        let label = GFBodyLabel(textAlignment: .left)
        label.numberOfLines = 3
        addSubview(label)
        return label
    }()
    
    var user: User!
    
    // MARK: - Initialisers
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Called outside
    func set(with user: User) {
        avatarImageView.downloadImage(from: user.avatarUrl, imageSize: .large)
        usernameLabel.text = user.login
        nameLabel.text = user.name ?? ""
        locationLabel.text = user.location ?? "No location"
        bioLabel.text = user.bio ?? "No bio available"
    }
    
    //MARK: - Layout configuration
    fileprivate func layoutUI() {
        let outsidePadding: CGFloat = 13
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint        (equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint    (equalTo: leadingAnchor, constant: outsidePadding),
            avatarImageView.widthAnchor.constraint      (equalToConstant: 90),
            avatarImageView.heightAnchor.constraint     (equalToConstant: 90),
            
            usernameLabel.topAnchor.constraint          (equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint      (equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint     (equalTo: trailingAnchor),
            usernameLabel.heightAnchor.constraint       (equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint          (equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint          (equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint         (equalTo: trailingAnchor),
            nameLabel.heightAnchor.constraint           (equalToConstant: 20),
            
            locationImageView.bottomAnchor.constraint   (equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint  (equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            locationImageView.widthAnchor.constraint    (equalToConstant: 20),
            locationImageView.heightAnchor.constraint   (equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint      (equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint      (equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint     (equalTo: trailingAnchor),
            locationLabel.heightAnchor.constraint       (equalToConstant: 20),
            
            bioLabel.topAnchor.constraint               (equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint           (equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint          (equalTo: trailingAnchor),
            bioLabel.heightAnchor.constraint            (equalToConstant: 90)
        ])
    }
}
