//
//  Follower.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 15/12/2020.
//

import UIKit

protocol FollowerProtocol: Codable, Identifiable {
    var login: String { set get }
    var avatarUrl: String { set get }
    var id: String { get }
}

extension FollowerProtocol {
    var id: String {
        return login
    }
}

/// Struct conforming to Identifiable instead of Hashable, then ID is given and collectionView is built upon that ID, not the actual Follower instance
struct Follower: FollowerProtocol {
    var login: String
    var avatarUrl: String
}


