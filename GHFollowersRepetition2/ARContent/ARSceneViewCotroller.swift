//
//  ARFollowerListVC.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 29/09/2021.
//

import UIKit
import RealityKit
import SceneKit
import ARKit

enum ARFollowerListDismissalOption {
    case justDismiss
    case dismissWithFollowers(followers: [Follower])
    case dismissAndPresentUser(user: [User])
}

protocol ARFollowerListVCDelegate: NSObject {
    func dismissedARFollowerList(with option: ARFollowerListDismissalOption)
}

class ARSceneViewCotroller: UIViewController {
    var followers: [Follower]
    var user: User
    weak var delegate: ARFollowerListVCDelegate?
    
    private lazy var sceneView: ARSCNView = {
        let view = ARSCNView(frame: .zero)
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var closeARButton: GF15ButtonTinted = {
        let button = GF15ButtonTinted(buttonTitle: "Go back",
                                      subtitle: nil,
                                      image: UIImage(systemName: "arkit.badge.xmark"),
                                      color: .systemGreen)
        button.addTarget(self, action: #selector(handleARCollectionDismissal), for: .touchUpInside)
        view.addSubview(button)
        return button
    }()
    
    @objc private func handleARCollectionDismissal() {
        delegate?.dismissedARFollowerList(with: .dismissWithFollowers(followers: followers))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutConstraints()
        
        let configuration = ARWorldTrackingConfiguration()
        
        sceneView.session.run(configuration)
        
        self.sceneView.scene.rootNode.addChildNode(createCollection())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    fileprivate func createCollection() -> SCNNode {
        let scene = SCNPlane(width: 0.5, height: 1)
        
        let followersARView = ARFollowersCollection(with: user).view
        
        scene.firstMaterial?.diffuse.contents = followersARView
        let planeNode = SCNNode(geometry: scene)
        planeNode.position = SCNVector3(x: 0, y: 0, z: -1)
        return planeNode
    }
    
    init(followers: [Follower], user: User, delegate: ARFollowerListVCDelegate?) {
        self.followers = followers
        self.delegate = delegate
        self.user = user
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    fileprivate func layoutConstraints() {
        NSLayoutConstraint.activate([
            sceneView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            closeARButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            closeARButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            closeARButton.widthAnchor.constraint(equalToConstant: 150),
            closeARButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
}
