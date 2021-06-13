//
//  NetworkManager.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 15/12/2020.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    let cache = NSCache<NSString, UIImage>()
    
    private let baserURL = "https://api.github.com/users/"
    
    private init() {}
   
   func getFollowers(username: String, page: Int) async throws -> [Follower] {
      let endpoint = baserURL + "\(username)/followers?per_page=100&page=\(page)"
      
      guard let url = URL(string: endpoint) else { throw GFError.invalidUsername }
      let request = URLRequest.init(url: url)
      
      let (data, response) = try await URLSession.shared.data(for: request)
      
      guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
         throw GFError.invalidResponse
      }
      
      do {
         let decoder = JSONDecoder()
         decoder.keyDecodingStrategy = .convertFromSnakeCase
         let followers = try decoder.decode([Follower].self, from: data)
         return followers
      } catch { throw GFError.invalidData }
   }
    
    
    /// Makes a network call in order to get specified user's information such as its location, repo count, gists count, bio etc.
    /// - Parameters:
    ///   - username: Search for user based on its username
    ///   - completed: Upon completion retrieve users information or custom user readable error
    func getUserInfo(username: String, completed: @escaping(Result<User, GFError>) -> Void) {
        let endpoint = baserURL + "\(username)"
        guard let url = URL(string: endpoint) else { completed(.failure(.invalidUsername)); return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error { completed(.failure(.unableToComplete)); return }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { completed(.failure(.invalidUsername)); return }
            
            guard let data = data else { completed(.failure(.invalidData)); return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            } catch { completed(.failure(.invalidData)) }
        }
        task.resume()
    }
   
   
   func getUserInfo(username: String) async throws -> User {
      let endpoint = baserURL + "\(username)"
      guard let url = URL(string: endpoint) else {
         throw GFError.invalidUsername
      }
      
      let request = URLRequest(url: url)
      
      let (data, response) = try await URLSession.shared.data(for: request)
      
      guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
         throw GFError.invalidResponse
      }
      
      do {
         let decoder = JSONDecoder()
         decoder.keyDecodingStrategy = .convertFromSnakeCase
         let user = try decoder.decode(User.self, from: data)
         return user
      } catch {
         throw GFError.invalidData
      }
   }
   
}
