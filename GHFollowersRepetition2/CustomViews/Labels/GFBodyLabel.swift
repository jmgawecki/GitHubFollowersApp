//
//  GFBodyLabel.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 15/12/2020.
//

import UIKit

class GFBodyLabel: UILabel {
    // MARK: - Initialisers
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
    }
    
    
    // MARK: - Configurationsb
    
    
    private func configure() {
        textColor   = .secondaryLabel
        font        = UIFont.preferredFont(forTextStyle: .body)
        
        minimumScaleFactor  = 0.75
        lineBreakMode       = .byWordWrapping
        
        adjustsFontSizeToFitWidth = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
