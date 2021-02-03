//
//  GFError.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 15/12/2020.
//

import UIKit

enum GFError: String, Error {
    case invalidUsername    = "This username created an invalid request. Please try again."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
    case unableToFavorites  = "Unable to favorites. Please try again"
    case inFavorites        = "That username is already in your favorites ;)"
}
