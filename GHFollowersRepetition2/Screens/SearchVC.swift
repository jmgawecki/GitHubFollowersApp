//
//  SearchVC.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 15/12/2020.
//

import UIKit

final class SearchVC: UIViewController {
    
    // MARK: - Declarations
    fileprivate lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "gh-logo")
        return imageView
    }()
    
    fileprivate lazy var usernameTextField: GFTextField = {
        let textField = GFTextField()
        view.addSubview(textField)
        textField.delegate = self
        textField.autocorrectionType = .no
        return textField
    }()
    
    fileprivate lazy var searchUsernameButton: GF15ButtonTinted = {
        let button = GF15ButtonTinted(buttonTitle: "Search", subtitle: "for the user", image: UIImage(systemName: "doc.text.magnifyingglass"), color: .systemGreen)
        view.addSubview(button)
        button.addTarget(self, action: #selector(pushVC), for: .touchUpInside)
        return button
    }()
    
    var isUsernameEntered: Bool { !usernameTextField.text!.isEmpty }
    var user: Follower!
    
    // MARK: - Initialisers
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImage()
        dismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Objectives
    @objc private func pushVC() {
        guard self.isUsernameEntered else {
            self.presentGFAlerOnMainThred(title: "Ops",
                                          message: "You forgot to type username! Go ahead and types someone's username 😇",
                                          button: "Okey")
            return
        }
        showLoadingView()
        async { [weak self] in
            guard let self = self else { return }
            do {
                self.dismissLoadingView()
                let user = try await NetworkManager.shared.getUserInfo(username: usernameTextField.text!)
                let followerListVC = FollowersListVC(with: user)
                self.navigationController?.pushViewController(followerListVC, animated: true)
            } catch let error {
                self.presentGFAlerOnMainThred(title: "Ops!", message: error.localizedDescription, button: "Okay")
            }
        }
    }
    
    // MARK: - Configurations
    private func dismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Layout configurations
    
    
    fileprivate func configureLogoImage() {
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 200),
            logoImage.widthAnchor.constraint(equalToConstant: 200),
            
            usernameTextField.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            searchUsernameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchUsernameButton.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 15),
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
