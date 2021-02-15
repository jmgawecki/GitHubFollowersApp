//
//  SearchVC.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 15/12/2020.
//

import UIKit

class SearchVC: UIViewController {
    // MARK: - Declarations
    
    
    let logoImage               = UIImageView()
    let usernameTextField       = GFTextField()
    let searchUsernameButton    = GFButton(message: "Search username", backgroundColor: .systemGreen)
    
    var isUsernameEntered: Bool { !usernameTextField.text!.isEmpty }
    var user: Follower!
    
    
    // MARK: - Initialisers
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImage()
        configureUsernameTextField()
        configureSearchButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    // MARK: - Objectives
    
    
    @objc func pushVC() {
        guard self.isUsernameEntered else { self.presentGFAlerOnMainThred(title: "Ops", message: "You forgot to type username! Go ahead and types someone's username 😇", button: "Okey"); return }
        showLoadingView()
        NetworkManager.shared.getUserInfo(username: usernameTextField.text!) { [weak self] (result) in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    let followersVC         = FollowersListVC()
                    followersVC.user        = user
                    self.navigationController?.pushViewController(followersVC, animated: true)
                }
            case .failure(let error):
                self.presentGFAlerOnMainThred(title: "Ops!", message: error.rawValue, button: "Okay")
            }
        }
    }

    
    // MARK: - Configurations
    
    
    private func dismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    
    // MARK: - Layout configurations
    
    
    private func configureLogoImage() {
        view.addSubview(logoImage)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.image = UIImage(named: "gh-logo")
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint                  (equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImage.centerXAnchor.constraint              (equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint               (equalToConstant: 200),
            logoImage.widthAnchor.constraint                (equalToConstant: 200)
        ])
    }
    
    private func configureUsernameTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint          (equalTo: logoImage.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint      (equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint     (equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint       (equalToConstant: 50)
        ])
    }
    
    private func configureSearchButton() {
        view.addSubview(searchUsernameButton)
        searchUsernameButton.addTarget(self, action: #selector(pushVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            searchUsernameButton.bottomAnchor.constraint    (equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            searchUsernameButton.leadingAnchor.constraint   (equalTo: view.leadingAnchor, constant: 50),
            searchUsernameButton.trailingAnchor.constraint  (equalTo: view.trailingAnchor, constant: -50),
            searchUsernameButton.heightAnchor.constraint    (equalToConstant: 50)
        ])
    }
}


// MARK: - Extensions


extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushVC()
        return true
    }
}
