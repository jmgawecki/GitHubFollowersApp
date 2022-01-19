//
//  FollowersListVC.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 15/12/2020.
//

import UIKit
import SwiftUI


// MARK: - Delegates

final class ARFollowersCollection: UIViewController {
    // MARK: - Declarations
    enum Section { case main }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower.ID>?
    
    var page = 1
    
    var user: User
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    
    var hasMoreFollowers = true
    var isSearching = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureDataSource()
        updateData(with: followers)
        getFollowers(page: page, on: user.login, forFollowers: .getFirstFollowers)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = nil
    }
    
    // MARK: - Init
    init(with user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Objectives
    @objc func addButtonTapped() {
        PersistenceManager.updateWith(favorite: user, actionType: .add) { [weak self] (error) in
            guard let self = self else { return }
            guard let error = error else {
                self.presentGFAlerOnMainThred(title: "Horray!",
                                              message: "You have succesfully added an user to favorites",
                                              button: "Done")
                return
            }
            self.presentGFAlerOnMainThred(title: "Ops", message: error.rawValue, button: "Shame.")
        }
    }
    
    // MARK: - Collection View configurations
    fileprivate lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createCompositionalLayout())
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowersCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FollowersCollectionHeaderView.reuseId)
        view.addSubview(collectionView)
        return collectionView
    }()
    
    fileprivate lazy var snapshot: NSDiffableDataSourceSnapshot<Section, Follower.ID> = {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower.ID>()
        snapshot.appendSections([.main])
        let itemIdentifiers = followers.map { $0.id }
        snapshot.appendItems(itemIdentifiers, toSection: .main)
        dataSource?.apply(snapshot, animatingDifferences: true)
        return snapshot
    }()
    
    func updateData(with followers: [Follower]) {
        snapshot = NSDiffableDataSourceSnapshot<Section, Follower.ID>()
        snapshot.appendSections([.main])
        let itemIdentifiers = followers.map { $0.id }
        snapshot.appendItems(itemIdentifiers, toSection: .main)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    fileprivate func updateSnapshot(with identifiers: [Follower.ID]) {
        var snapshot = dataSource?.snapshot()
        snapshot?.reconfigureItems(identifiers)
        guard let snapshot = snapshot else { return }
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    /// Prefetching is done automatically as of iOS15, it did not exists in iOS14 at all.
    fileprivate func configureDataSource() {
        // Registration outside the dataSource for performance reasons
        let cellRegistration = UICollectionView.CellRegistration<FollowerCell, Follower.ID> { [weak self]
            cell, indexPath, followerID in
            guard let self = self else { return }
            // Because the CellRegistration holds the reference to the ID, not the Follower object itself, we need to prefetch it from the array:
            let follower = (self.followers.filter { $0.id == followerID }).first
            cell.set(on: follower)
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Follower.ID>(collectionView: collectionView) {
            collectionView, indexPath, itemIdentifier in
            
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                for: indexPath,
                                                                item: itemIdentifier)
        }
        
        let headerRegistration = createSectionHeaderRegistration()
        dataSource?.supplementaryViewProvider = { collectionView, elementKind, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
    }
    
    fileprivate func createSectionHeaderRegistration() -> UICollectionView.SupplementaryRegistration<FollowersCollectionHeaderView> {
        return UICollectionView.SupplementaryRegistration<FollowersCollectionHeaderView>(
            elementKind: FollowersCollectionHeaderView.reuseId) { [weak self] supplementaryView, elementKind, indexPath in
            guard let self = self else { return }
            supplementaryView.set(with: self.user)
            }
    }
    
    
    // MARK: - Layout configurations
    
    
    fileprivate func configureVC() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Network Calls
    enum GetFollowersType {
        case getFirstFollowers
        case getNewFollowers
    }
    
    func getFollowers(page: Int, on username: String, forFollowers: GetFollowersType) {
        showLoadingView()
        switch forFollowers {
        case .getFirstFollowers:
            Task.init(priority: .high) {  // After that line, code after closure started execution, when that code finished completely, we went back here
                do {
                    self.dismissLoadingView()
                    let followers = try await NetworkManager.shared.getFollowers(username: username, page: page) // Right after this line, UI updated itself, so the thread was suspende
                    if followers.count < 100 { self.hasMoreFollowers.toggle() }
                    self.followers.append(contentsOf: followers)
                    self.updateData(with: followers)
                    if self.followers.isEmpty {
                        DispatchQueue.main.async {
                            self.showEmptyStateView(with: "Looks like that user has no followers. Go follow them!", in: self.view)
                        }
                    }
                } catch let error {
                    self.presentGFAlerOnMainThred(title: "Ops", message: error.localizedDescription, button: "Ok")
                }
            }
        case .getNewFollowers:
            Task.init(priority: .high) { [weak self] in
                guard let self = self else { return }
                do {
                    self.dismissLoadingView()
                    let followers = try await NetworkManager.shared.getFollowers(username: username, page: page)
                    if followers.count < 100 { self.hasMoreFollowers.toggle() }
                    self.followers.append(contentsOf: followers)
                    self.updateData(with: followers)
                    if self.followers.isEmpty {
                        DispatchQueue.main.async {
                            self.showEmptyStateView(with: "Looks like that user has no followers. Go follow them!",
                                                    in: self.view)
                            
                        }
                    }
                } catch let error {
                    self.presentGFAlerOnMainThred(title: "Ops", message: error.localizedDescription, button: "Ok")         }
            }
        }
    }
}

// MARK: - ColletionView Delegate
extension ARFollowersCollection: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(page: page, on: user.login, forFollowers: .getNewFollowers)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let activeArray = isSearching ? filteredFollowers : followers
//        let follower = activeArray[indexPath.item]
//        let destVC = UserInfoVC()
//        destVC.username = follower.login
//        destVC.user = user
//        destVC.follower = Follower(login: follower.login, avatarUrl: follower.avatarUrl)
//        destVC.delegate = self
//        let navbar = UINavigationController(rootViewController: destVC)
//        DispatchQueue.main.async { self.present(navbar, animated: true) }
    }
}
