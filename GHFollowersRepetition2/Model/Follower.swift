//
//  Follower.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 15/12/2020.
//

import UIKit

/// Struct conforming to Identifiable instead of Hashable, then ID is given and collectionView is built upon that ID, not the actual Follower instance
struct Follower: Codable, Identifiable {
   let login:      String
   let avatarUrl:  String
   var id: String { login }
}


