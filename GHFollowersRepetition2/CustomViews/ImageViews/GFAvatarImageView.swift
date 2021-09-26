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
    enum GFAvatarImageSize {
        case small
        case medium
        case large
        case original
    }
    
    func downloadImage(from urlString: String, imageSize: GFAvatarImageSize) {
        async {
            do {
                let image = try await NetworkManager.shared.getImage(from: urlString)
                
                switch imageSize {
                case .small:
                    self.image = await image?.byPreparingThumbnail(ofSize: CGSize(width: 60, height: 60))
                case .medium:
                    self.image = await image?.byPreparingThumbnail(ofSize: CGSize(width: 90, height: 90))
                case .large:
                    self.image = await image?.byPreparingThumbnail(ofSize: CGSize(width: 120, height: 120))
                case .original:
                    self.image = image
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
