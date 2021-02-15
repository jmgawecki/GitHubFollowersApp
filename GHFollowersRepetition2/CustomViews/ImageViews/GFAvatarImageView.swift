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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Configuration
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 16
        clipsToBounds = true
        image = avatarPlaceholder
    }
    
    
    //MARK: - Network call
    
    func downloadImage(from urlString: String) {
        
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) { self.image = image; return}
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error { return }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            self.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async { self.image = image }
        }
        task.resume()
    }
}
