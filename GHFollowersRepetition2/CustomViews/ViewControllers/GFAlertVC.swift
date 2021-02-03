//
//  GFAlertVC.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 15/12/2020.
//

import UIKit

class GFAlertVC: UIViewController {

    
    let containerView   = UIView()
    let titleLabel      = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let bodyLabel       = GFBodyLabel(textAlignment: .center)
    let dismissButton   = GFButton(message: "Ok", backgroundColor: .systemPink)
    
    let padding: CGFloat = 20
    
    var alertTitle: String?
    var message: String?
    var buttonLabel:String?
    
    init(alertTitle: String, message: String, buttonLabel: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.alertTitle     = alertTitle
        self.message        = message
        self.buttonLabel    = buttonLabel
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContainerView()
        configureTitleLabel()
        configureDismissButton()
        configureBodyLabel()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContainerView() {
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 220),
            containerView.widthAnchor.constraint(equalToConstant: 280)
        ])
    }
    
    func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Ops"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configureDismissButton() {
        view.addSubview(dismissButton)
        dismissButton.setTitle(buttonLabel ?? "okey dokey", for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            dismissButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            dismissButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            dismissButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            dismissButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc func dismissVC() { dismiss(animated: true) }
    
    func configureBodyLabel() {
        view.addSubview(bodyLabel)
        bodyLabel.text = message ?? "Something went wrong"
        bodyLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            bodyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            bodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            bodyLabel.bottomAnchor.constraint(equalTo: dismissButton.topAnchor, constant: -12)
        ])
    }
}
