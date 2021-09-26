//
//  GFAlertVC.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 15/12/2020.
//

import UIKit

class GFAlertVC: UIViewController {
    //MARK: - Declarations
    fileprivate lazy var containerView: UIView = {
        let container = UIView()
        view.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .systemBackground
        container.layer.cornerRadius = 16
        container.layer.borderWidth = 2
        container.layer.borderColor = UIColor.white.cgColor
        return container
    }()
    
    fileprivate lazy var titleLabel: GFTitleLabel = {
        let label = GFTitleLabel(textAlignment: .center, fontSize: 20)
        view.addSubview(label)
        label.text = alertTitle ?? "Ops"
        return label
    }()
    
    fileprivate lazy var bodyLabel: GFBodyLabel = {
        let label = GFBodyLabel(textAlignment: .center)
        view.addSubview(label)
        label.text = message ?? "Something went wrong"
        label.numberOfLines = 4
        return label
    }()
    
    fileprivate lazy var dismissButton15: GF15ButtonFilled = {
        let button = GF15ButtonFilled(buttonTitle: "Ok", subtitle: nil, image: nil, color: .systemPink)
        view.addSubview(button)
        button.configuration?.title = buttonLabel
        button.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        return button
    }()
    
    let padding: CGFloat    = 20
    
    var alertTitle: String?
    var message: String?
    var buttonLabel: String?
    
    // MARK: - Initialisers
    init(alertTitle: String, message: String, buttonLabel: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.message = message
        self.buttonLabel = buttonLabel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Objectives
    @objc func dismissVC() { dismiss(animated: true) }
    
    // MARK: - Layout configurations
    fileprivate func configureContainerView() {
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint  (equalTo: view.centerXAnchor, constant: 0),
            containerView.centerYAnchor.constraint  (equalTo: view.centerYAnchor),
            containerView.heightAnchor.constraint   (equalToConstant: 220),
            containerView.widthAnchor.constraint    (equalToConstant: 280),
            
            titleLabel.topAnchor.constraint         (equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint     (equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint    (equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint      (equalToConstant: 28),
            
            dismissButton15.bottomAnchor.constraint   (equalTo: containerView.bottomAnchor, constant: -padding),
            dismissButton15.leadingAnchor.constraint  (equalTo: containerView.leadingAnchor, constant: padding),
            dismissButton15.trailingAnchor.constraint (equalTo: containerView.trailingAnchor, constant: -padding),
            dismissButton15.heightAnchor.constraint   (equalToConstant: 44),
            
            bodyLabel.topAnchor.constraint          (equalTo: titleLabel.bottomAnchor, constant: 8),
            bodyLabel.leadingAnchor.constraint      (equalTo: containerView.leadingAnchor, constant: padding),
            bodyLabel.trailingAnchor.constraint     (equalTo: containerView.trailingAnchor, constant: -padding),
            bodyLabel.bottomAnchor.constraint       (equalTo: dismissButton15.topAnchor, constant: -12),
        ])
    }
}
