//
//  User.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 16/12/2020.
//

import UIKit


protocol UserProtocol {
    var login:          String  { get set }
    var avatarUrl:      String  { get set }
    var name:           String? { get set }
    var location:       String? { get set }
    var bio:            String? { get set }
    var publicRepos:    Int     { get set }
    var publicGists:    Int     { get set }
    var htmlUrl:        String  { get set }
    var followers:      Int     { get set }
    var following:      Int     { get set }
    var createdAt:      String  { get set }
}


struct User: Codable, Hashable, UserProtocol {
    var login:          String
    var avatarUrl:      String
    var name:           String?
    var location:       String?
    var bio:            String?
    var publicRepos:    Int
    var publicGists:    Int
    var htmlUrl:        String
    var followers:      Int
    var following:      Int
    var createdAt:      String
}


