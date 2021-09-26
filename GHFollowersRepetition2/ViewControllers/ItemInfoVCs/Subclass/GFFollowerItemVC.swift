//
//  GFFollowerItemVC.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 17/12/2020.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
    // MARK: - Initialisers
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    // MARK: - Configurations
    fileprivate func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, with: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, with: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        guard user.followers != 0 else { presentGFAlerOnMainThred(title: "Ops", message: "No followers", button: "Shame."); return}
        delegate.didTapGetFollowers(for: user, with: follower)
        dismiss(animated: true)
    }
}
