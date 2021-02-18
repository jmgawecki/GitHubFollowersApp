//
//  GFUserInfoHeaderVC.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 16/12/2020.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {
    // MARK: - Declarations
    
    
    let avatarImgV          = GFAvatarImageView(frame: .zero)
    let usernameLabel       = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel           = GFSecondaryTitleLabel(fontSize: 18)
    let locationImgV        = UIImageView(frame: .zero)
    let locationLabel       = GFSecondaryTitleLabel(fontSize: 18)
    let bioLabel            = GFBodyLabel(textAlignment: .left)
    
    var user: User!
    
    
    // MARK: - Initialisers
    
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElements()
        addSubview()
        layoutUI()

    }
    
    
    // MARK: - Layout configurations
    
    
    private func configureUIElements() {
        avatarImgV.downloadImage(from: user.avatarUrl)
        usernameLabel.text  = user.login
        nameLabel.text      = user.name ?? ""
        locationLabel.text  = user.location ?? "No location available"
        bioLabel.text       = user.bio ?? "No bio available"
        bioLabel.numberOfLines = 3
        locationImgV.image = UIImage(systemName: SFSymbols.location)
        locationImgV.tintColor = .systemGreen
    
    }
    
    
    private func addSubview() {
        view.addSubview(avatarImgV)
        view.addSubview(usernameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImgV)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)
    }
    
    
    private func layoutUI() {
        let padding: CGFloat            = 20
        let textImagePadding: CGFloat   = 12
        
        locationImgV.translatesAutoresizingMaskIntoConstraints = false
        
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
