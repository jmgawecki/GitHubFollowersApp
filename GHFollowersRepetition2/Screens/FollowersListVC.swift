//
//  FollowersListVC.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 15/12/2020.
//

import UIKit

protocol FollowerListDelegates: class {
    func didRequestNewFollowers(with user: User, with follower: Follower)
}

class FollowersListVC: UIViewController {
    
    enum Section { case main }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    var snapshot: NSDiffableDataSourceSnapshot<Section, Follower>!

    var page = 1
    
    var user:               User!
    var followers:          [Follower] = []
    var filteredFollowers:  [Follower] = []
    
    var hasMoreFollowers    = true
    var isSearching         = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        getFollowers(page: page, on: user.login)
        configureCollectionView()
        configureDataSource()
        
    }
    
    @objc func addButtonTapped() {
        PersistenceManager.updateWith(favorite: user, actionType: .add) { [weak self] (error) in
            guard let self = self else { return }
            guard let error = error else { self.presentGFAlerOnMainThred(title: "Horray!", message: "You have succesfully added an user to favorites", button: "Done"); return }
            self.presentGFAlerOnMainThred(title: "Ops", message: error.rawValue, button: "Shame.")
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = nil
    }
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        configureSearchController()
    }
   
    
    func getFollowers(page: Int, on username: String) {
        showLoadingView()
        NetworkManager.shared.getFollowers(username: username, page: page) { [weak self] (result) in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers.toggle() }
                self.followers.append(contentsOf: followers)
                self.updateData(on: self.followers)
                if self.followers.isEmpty {
                    DispatchQueue.main.async { self.showEmptyStateView(with: "Looks like that user has no followers. Go follow them!", in: self.view) }
                }
                
            case .failure(let error):
                self.presentGFAlerOnMainThred(title: "Ops", message: error.rawValue, button: "Ok")
            }
        }
    }
    
    func getNewFollowers(page: Int, on username: String) {
        showLoadingView()
        NetworkManager.shared.getFollowers(username: username, page: page) { [weak self] (result) in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers.toggle() }
                self.followers.append(contentsOf: followers)
                DispatchQueue.main.async {
                    self.dataSource = nil
                    self.configureDataSource()
                    self.snapshot = nil
                    self.updateData(on: self.followers)
                }
                
                if self.followers.isEmpty {
                    DispatchQueue.main.async { self.showEmptyStateView(with: "Looks like that user has no followers. Go follow them!", in: self.view) }
                }
                
            case .failure(let error):
                self.presentGFAlerOnMainThred(title: "Ops", message: error.rawValue, button: "Ok")
            }
        }
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createCompositionalLayout())
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
        collectionView.register(FollowersCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FollowersCollectionHeaderView.reuseId)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, followers) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as! FollowerCell
            cell.set(on: followers)
            return cell
        })
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                     withReuseIdentifier: FollowersCollectionHeaderView.reuseId,
                                                                     for: indexPath) as! FollowersCollectionHeaderView
            
            header.configureUIElements(with: self.user)
            return header
    }
    }
    
    func updateData(on followers: [Follower]) {
        snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func configureSearchController() {
        let searchController                    = UISearchController()
        
        searchController.searchResultsUpdater   = self
        searchController.searchBar.delegate     = self
        searchController.searchBar.placeholder  = "Type a username"
        navigationItem.searchController         = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        
    }
}

extension FollowersListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(page: page, on: user.login)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower    = activeArray[indexPath.item]
        let destVC      = UserInfoVC()
        destVC.username = follower.login
        destVC.user     = user
        destVC.follower = Follower(login: follower.login, avatarUrl: follower.avatarUrl)
        destVC.delegate = self
        let navbar = UINavigationController(rootViewController: destVC)
        DispatchQueue.main.async { self.present(navbar, animated: true) }
    }
}

extension FollowersListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        filteredFollowers = followers.filter {$0.login.lowercased().contains(filter.lowercased())}
        updateData(on: filteredFollowers)
        isSearching = true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followers)
    }
}

extension FollowersListVC: FollowerListDelegates {
    func didRequestNewFollowers(with user: User, with follower: Follower) {
        followers.removeAll()
        filteredFollowers.removeAll()
//        snapshot.deleteSections([.main])
        page        = 1
        self.user   = user
        collectionView.setContentOffset(.zero, animated: true)
        getNewFollowers(page: page, on: user.login)
    }
}
    
    


