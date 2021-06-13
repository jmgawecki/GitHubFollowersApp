//
//  FavoritesVC.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 15/12/2020.
//

import UIKit

class FavoritesVC: UIViewController {
    // MARK: - Declarations
    
    
    var followersTableView: UITableView!
    var favoritesArray:     [User] = []
    
    
    // MARK: - Initialisers
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        configureFollowersTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    
    // MARK: - Layout configurations
    
    
    private func configureFollowersTableView() {
        followersTableView = UITableView(frame: view.bounds)
        followersTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(followersTableView)
        followersTableView.rowHeight    = 80
        followersTableView.dataSource   = self
        followersTableView.delegate     = self
    
        followersTableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseId)
    }
    
    
    // MARK: - Network Calls
    
    
    private func getFavorites() {
        PersistenceManager.retreiveFavorites { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let favorites):
                if favorites.isEmpty { self.showEmptyStateView(with: "Looks like there are no favorites around here bruva.", in: self.view); return}
                self.favoritesArray = favorites
                
                DispatchQueue.main.async {
                    self.followersTableView.reloadData()
                    self.view.bringSubviewToFront(self.followersTableView)
                }
            case .failure(_):
                return
            }
        }
    }
}


// MARK: - Extensions


extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseId) as! FavoriteCell
        let favorite = favoritesArray[indexPath.row]
        cell.set(on: favorite)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favoritesArray[indexPath.row]
        let destVC = FollowersListVC15(with: favorite)
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    
}
