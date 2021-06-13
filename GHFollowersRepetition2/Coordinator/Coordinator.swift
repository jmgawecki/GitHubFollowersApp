//
//  Coordinator.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 12/04/2021.
//

import UIKit


protocol Coordinator {
    var childControllers:       [Coordinator] { get set }
    var navigationController:   UINavigationController { get set }
    
    func start()
}
