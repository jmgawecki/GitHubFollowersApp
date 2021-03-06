//
//  GFItemInfoVC.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 17/12/2020.
//

import UIKit

class GFItemInfoVC: UIViewController {
    // MARK: - Declarations
    
    
    let stackView       = UIStackView()
    let itemInfoViewOne = GFItemInfoView()
    let itemInfoViewTwo = GFItemInfoView()
    let actionButton    = GFButton()
    
    var user:           User!
    var follower:       Follower!
    weak var delegate:  UserInfoVCDelegate!
    
    
    // MARK: - Initialisers
    
    
    init(user: User, follower: Follower) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
        self.follower = follower
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        configureActionButton()
        layoutUI()
        configureStackView()
    }
    
    
    // MARK: - Objectives
    
    
    @objc func actionButtonTapped() {}
    
    
    // MARK: - Layout configurations
    
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor    = .secondarySystemBackground
    }
    
    
    private func layoutUI() {
        view.addSubview(stackView)
        view.addSubview(actionButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint          (equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint      (equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint     (equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint       (equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint    (equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint   (equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint  (equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint    (equalToConstant: 44),
        ])
    }
    
    
    private func configureStackView() {
        stackView.axis          = .horizontal
        stackView.distribution  = .equalSpacing
        
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }
    
    private func hire(when: String) {}
    
    
    private func configureActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        let candidatesName = "Jakub"
        
        if candidatesName == "Jakub" {
            hire(when: "now")
        }
        
    }
    
   
    
}
