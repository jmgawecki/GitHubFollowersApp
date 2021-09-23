//
//  GFAvatarImageView.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 15/12/2020.
//

import UIKit

class GFAvatarImageView: UIImageView {
    // MARK: - Declarations
    let cache = NetworkManager.shared.cache
    var avatarPlaceholder = UIImage(named: "avatar-placeholder")
    
    // MARK: - Initialisers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Configuration
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 16
        clipsToBounds = true
        image = avatarPlaceholder
    }

    //MARK: - Network call    
    func downloadImage(from urlString: String) {
        async {
            do {
                image = try await NetworkManager.shared.getImage(from: urlString)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
