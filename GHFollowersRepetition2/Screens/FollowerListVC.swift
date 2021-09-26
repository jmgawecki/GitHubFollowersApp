//
//  FollowersListVC.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 15/12/2020.
//

import UIKit


// MARK: - Delegates
protocol FollowerListDelegates: NSObject {
    func didRequestNewFollowers(with user: User, with follower: Follower)
}

final class FollowersListVC: UIViewController {
    // MARK: - Declarations
    enum Section { case main }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower.ID>?
    
    var page = 1
    
    var user: User
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    
    var hasMoreFollowers = true
    var isSearching = false
    
    // MARK: - UI Elements
    fileprivate lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Type a username"
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
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
    
    fileprivate func updateData(with followers: [Follower]) {
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
        view.backgroundColor                                    = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles  = true
        navigationItem.rightBarButtonItem                       = UIBarButtonItem(barButtonSystemItem: .add,
                                                                                  target: self,
                                                                                  action: #selector(addButtonTapped))
        self.navigationItem.searchController = searchController
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
            async { [weak self] in // After that line, code after closure started execution, when that code finished completely, we went back here
                guard let self = self else { return }
                do {
                    self.dismissLoadingView()
                    let followers = try await NetworkManager.shared.getFollowers(username: username, page: page) // Right after this line, UI updated itself, so the thread was suspende
                    if followers.count < 100 { self.hasMoreFollowers.toggle() }
                    self.followers.append(contentsOf: followers)
                    self.updateData(with: followers)
//                    snapshot.reconfigureItems(followers.map { $0.id })
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
            async { [weak self] in
                guard let self = self else { return }
                do {
                    self.dismissLoadingView()
                    let followers = try await NetworkManager.shared.getFollowers(username: username, page: page)
                    if followers.count < 100 { self.hasMoreFollowers.toggle() }
                    self.followers.append(contentsOf: followers)
                    self.updateData(with: followers)
//                    self.updateSnapshot(with: self.followers.map { $0.id })
//                    let identifiers = followers.map { $0.id }
//                    snapshot.reconfigureItems(identifiers)
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
extension FollowersListVC: UICollectionViewDelegate {
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
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        let destVC = UserInfoVC()
        destVC.username = follower.login
        destVC.user = user
        destVC.follower = Follower(login: follower.login, avatarUrl: follower.avatarUrl)
        destVC.delegate = self
        let navbar = UINavigationController(rootViewController: destVC)
        DispatchQueue.main.async { self.present(navbar, animated: true) }
    }
}

// MARK: - SearchBar Delegate
extension FollowersListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        filteredFollowers = followers.filter {$0.login.lowercased().contains(filter.lowercased())}
        updateData(with: filteredFollowers)
        isSearching = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(with: followers)
    }
}

// MARK: - FollowerList Delegate
extension FollowersListVC: FollowerListDelegates {
    func didRequestNewFollowers(with user: User, with follower: Follower) {
        followers.removeAll()
        filteredFollowers.removeAll()
        page = 1
        self.user = user
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(page: page, on: user.login, forFollowers: .getNewFollowers)
    }
}
