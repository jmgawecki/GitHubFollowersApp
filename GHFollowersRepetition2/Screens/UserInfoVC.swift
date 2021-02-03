//
//  UserInfoVC.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 16/12/2020.
//

import UIKit
import SafariServices

protocol UserInfoVCDelegate: class {
    func didTapGitHubProfile(for user: User)
    func didTapGetFollowers(for user: User, with follower: Follower)
}

class UserInfoVC: UIViewController {
    
    let headerView  = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel   = GFBodyLabel(textAlignment: .center)
    var uiViewsArray: [UIView] = []
    
    var username: String!
    var follower: Follower!
    var user:     User!
    weak var delegate: FollowerListDelegates!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureDoneButton()
        layoutUI()
        getUserInfo()
    }
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(username: username) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.configureUIElements(with: user) }
                
            case .failure(let error):
                self.presentGFAlerOnMainThred(title: "Ops!", message: error.rawValue, button: "Okay")
            }
        }
    }
    
    func configureUIElements(with user: User) {
            let repoItemVC      = GFRepoItemVC(user: user, follower: follower)
            repoItemVC.delegate = self
            
            let followerItemVC      = GFFollowerItemVC(user: user, follower: follower)
            followerItemVC.delegate = self
            
            self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
            self.add(childVC: repoItemVC, to: self.itemViewOne)
            self.add(childVC: followerItemVC, to: self.itemViewTwo)
            self.dateLabel.text = "Github user since \(user.createdAt.convertToDisplayFormat())"
    }
    
    func configureVC() {
        view.backgroundColor = .systemBackground
    }
    
    func configureDoneButton() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    @objc func dismissVC() {
        dismiss(animated: true)
    }

    func layoutUI() {
        uiViewsArray = [headerView, itemViewOne, itemViewTwo, dateLabel]
        for views in uiViewsArray {
            view.addSubview(views)
            views.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: 140),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: 140),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}

extension UserInfoVC: UserInfoVCDelegate {
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else { presentGFAlerOnMainThred(title: "Oops", message: "wrong website", button: "whateva"); return }
        presentSafariVC(with: url)
    }
    
    func didTapGetFollowers(for user: User, with follower: Follower) {
        delegate.didRequestNewFollowers(with: user, with: follower)
    }
}
