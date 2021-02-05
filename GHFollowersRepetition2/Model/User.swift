//
//  User.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 16/12/2020.
//

import UIKit

struct User: Codable, Hashable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let followers: Int
    let following: Int
    let createdAt: String
}