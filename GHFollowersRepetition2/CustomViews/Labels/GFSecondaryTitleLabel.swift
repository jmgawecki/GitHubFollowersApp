//
//  GFSecondaryTitleLabel.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 16/12/2020.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        configure()
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontSizeToFitWidth = true
        
        minimumScaleFactor  = 0.9
        lineBreakMode       = .byTruncatingTail
        textColor           = .secondaryLabel
    }
}
