//
//  GFRepoItemVC.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 17/12/2020.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
    // MARK: - Initialisers
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    // MARK: - Configurations
    fileprivate func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, with: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, with: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub profile")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
}
