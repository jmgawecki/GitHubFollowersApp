//
//  GFUserInfoHeaderVC.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 16/12/2020.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {
    // MARK: - Declarations
    fileprivate lazy var avatarImgV: GFAvatarImageView = {
        let imageView = GFAvatarImageView(frame: .zero)
        view.addSubview(imageView)
        imageView.downloadImage(from: user.avatarUrl, imageSize: .large)
        return imageView
    }()
    
    fileprivate lazy var usernameLabel: GFTitleLabel = {
        let label = GFTitleLabel(textAlignment: .left, fontSize: 34)
        view.addSubview(label)
        label.text  = user.login
        return label
    }()
    
    fileprivate lazy var nameLabel: GFSecondaryTitleLabel = {
        let label = GFSecondaryTitleLabel(fontSize: 18)
        view.addSubview(label)
        label.text = user.name ?? ""
        return label
    }()
    
    fileprivate lazy var locationImgV: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        imageView.image = UIImage(systemName: SFSymbols.location)
        imageView.tintColor = .systemGreen
        return imageView
    }()
    
    fileprivate lazy var locationLabel: GFSecondaryTitleLabel = {
        let label = GFSecondaryTitleLabel(fontSize: 18)
        view.addSubview(label)
        label.text  = user.location ?? "No location available"
        return label
    }()
    fileprivate lazy var bioLabel: GFBodyLabel = {
        let label = GFBodyLabel(textAlignment: .left)
        view.addSubview(label)
        label.text = user.bio ?? "No bio available"
        label.numberOfLines = 3
        return label
    }()
    
    var user: User
    
    // MARK: - Initialisers
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
    }
    
    // MARK: - Layout configurations
    private func layoutUI() {
        let padding: CGFloat            = 20
        let textImagePadding: CGFloat   = 12
        
        NSLayoutConstraint.activate([
            avatarImgV.topAnchor.constraint         (equalTo: view.topAnchor, constant: padding),
            avatarImgV.leadingAnchor.constraint     (equalTo: view.leadingAnchor, constant: padding),
            avatarImgV.heightAnchor.constraint      (equalToConstant: 90),
            avatarImgV.widthAnchor.constraint       (equalToConstant: 90),
            
            usernameLabel.topAnchor.constraint      (equalTo: avatarImgV.topAnchor),
            usernameLabel.leadingAnchor.constraint  (equalTo: avatarImgV.trailingAnchor, constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint (equalTo: view.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint   (equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint      (equalTo: avatarImgV.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint      (equalTo: avatarImgV.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint     (equalTo: view.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint       (equalToConstant: 20),
            
            locationImgV.bottomAnchor.constraint    (equalTo: avatarImgV.bottomAnchor),
            locationImgV.leadingAnchor.constraint   (equalTo: avatarImgV.trailingAnchor, constant: textImagePadding),
            locationImgV.heightAnchor.constraint    (equalToConstant: 20),
            locationImgV.widthAnchor.constraint     (equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint  (equalTo: locationImgV.centerYAnchor),
            locationLabel.leadingAnchor.constraint  (equalTo: locationImgV.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint (equalTo: view.trailingAnchor, constant: padding),
            locationLabel.heightAnchor.constraint   (equalToConstant: 20),
            
            bioLabel.topAnchor.constraint           (equalTo: avatarImgV.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint       (equalTo: avatarImgV.leadingAnchor),
            bioLabel.trailingAnchor.constraint      (equalTo: view.trailingAnchor, constant: -padding),
            bioLabel.heightAnchor.constraint        (equalToConstant: 60)
        ])
    }
}
