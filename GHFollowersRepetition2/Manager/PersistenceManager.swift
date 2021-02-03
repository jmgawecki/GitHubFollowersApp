//
//  PersistenceManager.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 20/12/2020.
//

import UIKit

enum KeyObjects {
    static let favorites = "favorites"
}

enum PersistenceActionType { case add, remove }

enum PersistenceManager {
    static let defaults = UserDefaults.standard
    
    static func updateWith(favorite: User, actionType: PersistenceActionType, completed: @escaping(GFError?) -> Void) {
        retreiveFavorites { (result) in
            switch result {
            case .success(let favoritesArray):
                var retrievedFavorites = favoritesArray
                switch actionType {
                case .add:
                    guard !retrievedFavorites.contains(favorite) else { completed(.inFavorites); return}
                    retrievedFavorites.append(favorite)
                case .remove:
                    retrievedFavorites.removeAll { $0.login == favorite.login}
                }
                completed(saveFavorites(followers: retrievedFavorites))
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retreiveFavorites(completed: @escaping(Result<[User], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: KeyObjects.favorites) as? Data else { completed(.success([])); return}
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([User].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorites))
        }
    }
    
    static func saveFavorites(followers: [User]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let favorites = try encoder.encode(followers)
            defaults.set(favorites, forKey: KeyObjects.favorites)
            return nil
        } catch {
            return .unableToFavorites
        }
    }
}
